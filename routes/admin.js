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



// // Route to get the dashboard data
//     router.get('/dashboard', isAuthenticated, (req, res) => {
//         // Get department counts
//         db.query('SELECT department, COUNT(*) AS count FROM complaints GROUP BY department', (err, departmentResults) => {
//             if (err) {
//                 console.error('Error retrieving department counts:', err);
//                 return res.status(500).send('Error retrieving department counts');
//             }
//             // Get status counts
//             db.query('SELECT status, COUNT(*) AS count FROM complaints GROUP BY status', (err, statusResults) => {
//                 if (err) {
//                     console.error('Error retrieving status counts:', err);
//                     return res.status(500).send('Error retrieving status counts');
//                 } 
//                 // Get year level counts
//                 db.query('SELECT year_level, COUNT(*) AS count FROM complaints GROUP BY year_level', (err, yearLevelResults) => {
//                     if (err) {
//                         console.error('Error retrieving year level counts:', err);
//                         return res.status(500).send('Error retrieving year level counts');
//                     } 
//                     // Prepare department counts
//                     const departmentCounts = {};
//                     departmentResults.forEach(row => {
//                         departmentCounts[row.department] = row.count;
//                     });  
//                     // Prepare status counts
//                     const statusCounts = {};
//                     statusResults.forEach(row => {
//                         statusCounts[row.status] = row.count;
//                     });  
//                     // Prepare year level counts
//                     const yearLevelCounts = {};
//                     yearLevelResults.forEach(row => {
//                         yearLevelCounts[row.year_level] = row.count;
//                     });
//                     // Render the dashboard with department, status, and year level counts
//                     res.render('dashboard', { departmentCounts, statusCounts, yearLevelCounts });
//                 });
//             });
//         });
//     });
    


router.get('/dashboard', isAuthenticated, (req, res) => {
    // Get department counts
    db.query('SELECT department, COUNT(*) AS count FROM complaints GROUP BY department', (err, departmentResults) => {
        if (err) return res.status(500).send('Error retrieving department counts');

        // Get status counts
        db.query('SELECT status, COUNT(*) AS count FROM complaints GROUP BY status', (err, statusResults) => {
            if (err) return res.status(500).send('Error retrieving status counts');

            // Get year level counts
            db.query('SELECT year_level, COUNT(*) AS count FROM complaints GROUP BY year_level', (err, yearLevelResults) => {
                if (err) return res.status(500).send('Error retrieving year level counts');

                // Get monthly trends
                db.query('SELECT MONTHNAME(created_at) AS month, COUNT(*) AS count FROM complaints GROUP BY MONTH(created_at)', (err, monthlyResults) => {
                    if (err) return res.status(500).send('Error retrieving monthly trends');

                    // Get weekly trends
                    db.query('SELECT WEEK(created_at) AS week, COUNT(*) AS count FROM complaints GROUP BY WEEK(created_at)', (err, weeklyResults) => {
                        if (err) return res.status(500).send('Error retrieving weekly trends');

                        // Prepare data
                        const departmentCounts = departmentResults.reduce((acc, row) => {
                            acc[row.department] = row.count;
                            return acc;
                        }, {});

                        const statusCounts = statusResults.reduce((acc, row) => {
                            acc[row.status] = row.count;
                            return acc;
                        }, {});

                        const yearLevelCounts = yearLevelResults.reduce((acc, row) => {
                            acc[row.year_level] = row.count;
                            return acc;
                        }, {});

                        const monthlyTrends = monthlyResults.reduce((acc, row) => {
                            acc[row.month] = row.count;
                            return acc;
                        }, {});

                        const weeklyTrends = weeklyResults.reduce((acc, row) => {
                            acc[row.week] = row.count;
                            return acc;
                        }, {});

                        // Render the dashboard with all data
                        res.render('dashboard', {
                            departmentCounts,
                            statusCounts,
                            yearLevelCounts,
                            monthlyTrends,
                            weeklyTrends
                        });
                    });
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

                const yearLevelCounts = {};
                yearLevelResults.forEach(row => {
                    yearLevelCounts[row.year_level] = row.count;
                });

                // Get status counts
                db.query('SELECT status, COUNT(*) AS count FROM complaints GROUP BY status', (err, statusResults) => {
                    if (err) {
                        console.error('Error retrieving status counts:', err);
                        return res.status(500).send('Error retrieving status counts');
                    }

                    const statusCounts = {};
                    statusResults.forEach(row => {
                        statusCounts[row.status] = row.count;
                    });

                    // Monthly Trends Query (example)
                    db.query('SELECT MONTH(created_at) AS month, COUNT(*) AS count FROM complaints GROUP BY month ORDER BY month ASC', (err, monthlyResults) => {
                        if (err) {
                            console.error('Error retrieving monthly trends:', err);
                            return res.status(500).send('Error retrieving monthly trends');
                        }

                        const monthlyTrends = monthlyResults.map(row => ({
                            month: row.month,
                            count: row.count
                        }));

                        // Weekly Trends Query (example)
                        db.query('SELECT WEEK(created_at) AS week, COUNT(*) AS count FROM complaints GROUP BY week ORDER BY week ASC', (err, weeklyResults) => {
                            if (err) {
                                console.error('Error retrieving weekly trends:', err);
                                return res.status(500).send('Error retrieving weekly trends');
                            }

                            const weeklyTrends = weeklyResults.map(row => ({
                                week: row.week,
                                count: row.count
                            }));

                            // Render the page and pass all the necessary data
                            res.render('adminComplaints', {
                                complaints,
                                departmentCounts,
                                yearLevelCounts,
                                statusCounts,
                                monthlyTrends,  // Pass monthly trends
                                weeklyTrends    // Pass weekly trends
                            });
                        });
                    });
                });
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

// Route to get severity analysis data
router.get('/dashboard/severity-analysis', isAuthenticated, async (req, res) => {
    try {
        // Query to get severity counts
        db.query(
            `SELECT severity, COUNT(*) AS count FROM complaints GROUP BY severity`,
            (err, results) => {
                if (err) {
                    console.error('Error retrieving severity counts:', err);
                    return res.status(500).json({ message: 'Error retrieving severity counts' });
                }

                // Prepare severity counts
                const severityCounts = {
                    severe: 0,
                    mild: 0,
                    normal: 0,
                };

                results.forEach(row => {
                    severityCounts[row.severity] = row.count;
                });

                res.json(severityCounts); // Send JSON response for frontend chart rendering
            }
        );
    } catch (error) {
        console.error('Error in severity analysis route:', error);
        res.status(500).json({ message: 'Server error' });
    }
});



// Fetch severity data
router.get('/severity-data', (req, res) => {
    // Query data from the correct table and column
    db.query('SELECT sentiment AS severity, count(*) AS count FROM complaints GROUP BY sentiment', (error, results) => {
        if (error) {
            console.error('Error fetching severity data:', error);
            res.status(500).json({ error: 'Failed to fetch data' });
        } else {
            res.json(results);
        }
    });
});



export default router;
