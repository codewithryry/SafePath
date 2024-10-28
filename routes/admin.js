import express from 'express';
import db from '../config/db.js';
import { analyzeSeverity } from '../utils/analyzeSeverity.js';
import { isAuthenticated } from '../middlewares/authMiddleware.js';


const router = express.Router();

// Route to submit a complaint
router.post('/complaints', async (req, res) => {
    const { description, ...otherData } = req.body;

    // Validate description
    if (!description || typeof description !== 'string' || description.trim().length === 0) {
        return res.status(400).json({ message: 'Description is required and cannot be empty.' });
    }

    try {
        const severity = await analyzeSeverity(description); // Analyze severity

        // Prepare the complaint data
        const complaintData = {
            ...otherData,
            description,
            severity, // Add severity to the complaint data
            created_at: new Date(),
            status: 'Pending', // Set initial status
        };

        // Save to the database
        db.query('INSERT INTO complaints SET ?', complaintData, (err, result) => {
            if (err) {
                console.error('Error saving complaint:', err);
                return res.status(500).json({ message: 'Error saving complaint' });
            }
            res.json({ message: 'Complaint submitted successfully', id: result.insertId, severity });
        });
    } catch (error) {
        console.error('Error analyzing severity:', error);
        res.status(500).json({ message: 'Error analyzing severity' });
    }
});



// Route to get the dashboard data
router.get('/dashboard', isAuthenticated, (req, res) => {
    db.query('SELECT * FROM complaints ORDER BY created_at DESC', (err, complaints) => {
        if (err) {
            console.error('Error retrieving complaints:', err);
            return res.status(500).send('Error retrieving complaints');
        }

   //     console.log('Retrieved complaints:', complaints);

        // Get department counts
        db.query('SELECT department, COUNT(*) AS count FROM complaints GROUP BY department', (err, departmentResults) => {
            if (err) {
                console.error('Error retrieving department counts:', err);
                return res.status(500).send('Error retrieving department counts');
            }

            // Get status counts
            db.query('SELECT status, COUNT(*) AS count FROM complaints GROUP BY status', (err, statusResults) => {
                if (err) {
                    console.error('Error retrieving status counts:', err);
                    return res.status(500).send('Error retrieving status counts');
                }

                // Retrieve feedback data
                const feedbackQuery = 'SELECT * FROM feedback ORDER BY created_at DESC';
                db.query(feedbackQuery, (err, feedback) => {
                    if (err) {
                        console.error('Error retrieving feedback:', err);
                        return res.status(500).send('Error retrieving feedback');
                    }

                    const departmentCounts = {};
                    departmentResults.forEach(row => {
                        departmentCounts[row.department] = row.count;
                    });

                    const statusCounts = {};
                    statusResults.forEach(row => {
                        statusCounts[row.status] = row.count;
                    });

                    // Render the dashboard with all the data
                    res.render('dashboard', { complaints, departmentCounts, statusCounts, feedback });
                });
            });
        });
    });
});

router.get('/get-status-counts', async (req, res) => {
    try {
        const counts = await db.query(`
            SELECT 
                status, COUNT(*) as count 
            FROM 
                complaints 
            GROUP BY 
                status
        `);

        const statusCounts = {
            pending: 0,
            in_progress: 0,
            resolved: 0,
            rejected: 0
        };

        counts.forEach(row => {
            statusCounts[row.status] = row.count;
        });

        res.json(statusCounts);
    } catch (error) {
        console.error('Error fetching status counts:', error);
        res.status(500).send('Server Error');
    }
});

export default router;
