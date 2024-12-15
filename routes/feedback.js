// import express from 'express';
// import db from '../config/db.js'; // Ensure the .js extension is included
// import { submitFeedback } from '../controllers/feedbackController.js'; // Correct path

// const router = express.Router();

// // Handle the submission of feedback (POST)
// router.post('/submit-feedback', submitFeedback);

// // Handle retrieving feedback (GET)
// router.get('/feedback', (req, res) => {
//     const query = 'SELECT * FROM feedback';

//     db.query(query, (err, results) => {
//         if (err) {
//             console.error('Error fetching feedback:', err);
//             return res.status(500).send('An error occurred while fetching feedback.');
//         }
//         res.json(results); // Send back the feedback data as JSON
//     });
// });

// export default router;

import express from 'express';
import db from '../config/db.js';
import { submitFeedback } from '../controllers/feedbackController.js'; // Correct path

const router = express.Router();



// Handle the submission of feedback (POST)
router.post('/submit-feedback', submitFeedback);

// Handle retrieving feedback (GET)
router.get('/feedback', (req, res) => {
    const query = 'SELECT * FROM feedback';

    db.all(query, (err, results) => {  // Use db.all for multiple rows in SQLite
        if (err) {
            console.error('Error fetching feedback:', err);
            return res.status(500).send('An error occurred while fetching feedback.');
        }
        res.json(results); // Send back the feedback data as JSON
    });
});

export default router;
