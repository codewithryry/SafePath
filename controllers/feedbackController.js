import db from '../config/db.js'; // Ensure the .js extension is included

// Handle the submission of feedback
export const submitFeedback = (req, res) => {
    const { name, email, feedback, rating, suggestions, recommend } = req.body;

    
    // Check for required fields
    if (!name || !email || !feedback || !rating) {
        return res.status(400).send('Please provide all required fields.');
    }

    const query = 'INSERT INTO feedback (name, email, feedback, rating, suggestions, recommend) VALUES (?, ?, ?, ?, ?, ?)';
    
    db.query(query, [name, email, feedback, rating, suggestions, recommend], (err, results) => {
        if (err) {
            console.error('Error inserting feedback:', err);
            return res.status(500).send('An error occurred while submitting feedback.');
        }
        
        // Redirect to feedback page with a query parameter indicating success
        res.redirect('/user/feedback?adding=true');
    });
};
