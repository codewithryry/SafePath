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
                // Get year level counts
                db.query('SELECT year_level, COUNT(*) AS count FROM complaints GROUP BY year_level', (err, yearLevelResults) => {
                    if (err) {
                        console.error('Error retrieving year level counts:', err);
                        return res.status(500).send('Error retrieving year level counts');
                    } 
                    // Prepare department counts
                    const departmentCounts = {};
                    departmentResults.forEach(row => {
                        departmentCounts[row.department] = row.count;
                    });  
                    // Prepare status counts
                    const statusCounts = {};
                    statusResults.forEach(row => {
                        statusCounts[row.status] = row.count;
                    });  
                    // Prepare year level counts
                    const yearLevelCounts = {};
                    yearLevelResults.forEach(row => {
                        yearLevelCounts[row.year_level] = row.count;
                    });
                    // Render the dashboard with department, status, and year level counts
                    res.render('dashboard', { departmentCounts, statusCounts, yearLevelCounts });
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


// Route to get feedback data and department counts
router.get('/dashboard/feedback', isAuthenticated, (req, res) => {
    // Query to get feedback
    db.query('SELECT * FROM feedback ORDER BY created_at DESC', (err, feedback) => {
        if (err) {
            console.error('Error retrieving feedback:', err);
            return res.status(500).send('Error retrieving feedback');
        }
        // Initialize departmentCounts to an empty object
        let departmentCounts = {};
        // Query to get department counts
        db.query('SELECT department, COUNT(*) as count FROM feedback GROUP BY department', (err, counts) => {
            if (err) {
                console.error('Error retrieving department counts:', err);
                // Optionally log the error, but continue rendering with empty departmentCounts
            } else {
                // Transform departmentCounts to an object if the query is successful
                counts.forEach(row => {
                    departmentCounts[row.department] = row.count;
                });
            }
            // Render feedback view with both feedback and department data
            res.render('adminFeedback', { feedback, departmentCounts });
        });
    });
});

// Route to get complaints data with department counts and year level counts
router.get('/dashboard/complaints', isAuthenticated, (req, res) => {
    db.query('SELECT * FROM complaints ORDER BY created_at DESC', (err, complaints) => {
        if (err) {
            console.error('Error retrieving complaints:', err);
            return res.status(500).send('Error retrieving complaints');
        }
        // Get department counts
        db.query('SELECT department, COUNT(*) AS count FROM complaints GROUP BY department', (err, departmentResults) => {
            if (err) {
                console.error('Error retrieving department counts:', err);
                return res.status(500).send('Error retrieving department counts');
            }
            // Prepare department counts
            const departmentCounts = {};
            departmentResults.forEach(row => {
                departmentCounts[row.department] = row.count;
            });
            // Get year level counts
            db.query('SELECT year_level, COUNT(*) AS count FROM complaints GROUP BY year_level', (err, yearLevelResults) => {
                if (err) {
                    console.error('Error retrieving year level counts:', err);
                    return res.status(500).send('Error retrieving year level counts');
                }
                // Prepare year level counts
                const yearLevelCounts = {};
                yearLevelResults.forEach(row => {
                    yearLevelCounts[row.year_level] = row.count;
                });
                // Render complaints view with department counts and year level counts
                res.render('adminComplaints', { complaints, departmentCounts, yearLevelCounts }); // Pass yearLevelCounts to the view
            });
        });
    });

    
});

// GET all FAQs
router.get('/admin/dashboard/customization/faq', (req, res) => {
    db.query('SELECT * FROM faqs', (error, faqs) => {
        if (error) {
            console.error('Error fetching FAQs:', error);
            return res.status(500).json({ error: 'Internal server error' });
        }
        res.json(faqs);
    });
});



router.post('/admin/dashboard/customization/faq', (req, res) => {
    const { question, answer } = req.body;
    // Log incoming data for debugging
    console.log('Received FAQ:', { question, answer });
    if (!question || !answer) {
        return res.status(400).json({ error: 'Question and answer are required' });
    }
    db.query('INSERT INTO faqs (question, answer) VALUES (?, ?)', [question, answer], (err, results) => {
        if (err) {
            console.error('Error adding FAQ:', err);
            return res.status(500).json({ error: 'Internal server error' });
        }
        res.status(201).json({ message: 'FAQ added successfully!', id: results.insertId });
    });
});



// GET all "Why We Are Here" content
router.get('/admin/dashboard/customization/why-we-are-here', (req, res) => {
    db.query('SELECT * FROM why_we_are_here', (error, whyWeAreHere) => {
        if (error) {
            console.error('Error fetching "Why We Are Here" content:', error);
            return res.status(500).json({ error: 'Internal server error' });
        }
        res.json(whyWeAreHere);
    });
});


// POST to add new "Why We Are Here" content
router.post('/admin/dashboard/customization/why-we-are-here', (req, res) => {
    const { title, paragraph1, paragraph2, paragraph3, video_link } = req.body;
    // Validate required fields
    if (!title || !paragraph1 || !paragraph2 || !paragraph3) {
        return res.status(400).json({ error: 'All fields are required' });
    }
    // Add your logic to save the data to the database
    const sql = 'INSERT INTO why_we_are_here (title, paragraph1, paragraph2, paragraph3, video_link) VALUES (?, ?, ?, ?, ?)';
    db.query(sql, [title, paragraph1, paragraph2, paragraph3, video_link], (error, results) => {
        if (error) {
            console.error('Error saving content:', error);
            return res.status(500).send('Error saving content'); // Send an error response
        }
        res.status(201).json({ message: 'Content added successfully!', id: results.insertId }); // Send success response with ID
    });
});



export default router;
