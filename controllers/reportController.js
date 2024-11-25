// import db from '../config/db.js'; // Ensure the .js extension is included


// // Get all complaints
// export const getComplaints = (req, res) => {
//     const query = 'SELECT * FROM complaints ORDER BY created_at DESC'; // Adjust query based on your DB schema

//     db.query(query, (err, results) => {
//         if (err) {
//             console.error('Error fetching complaints:', err);
//             return res.status(500).send('Error fetching complaints');
//         }
//       //  console.log('Fetched complaints:', results); // Log the results for debugging
//         res.render('admin', { complaints: results || [] }); // Ensure results are passed
//     });
// };

// export const submitComplaint = (req, res) => {
//     const { name, email, student_id, department, other_department, year_level, issue_type, issue_description, contact_method, phone_number, other_contact_method } = req.body;

//     const query = `
//         INSERT INTO complaints (name, email, student_id, department, other_department, year_level, issue_type, issue_description, contact_method, phone_number, other_contact_method)
//         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
//     `;

//     db.query(query, [name, email, student_id, department, other_department, year_level, issue_type, issue_description, contact_method, phone_number, other_contact_method], (err, result) => {
//         if (err) {
//             console.error('Error saving complaint:', err);
//             return res.status(500).send('Error saving complaint');
//         }
//         res.redirect('/report?adding=true'); // Redirect to report page with success flag
//     });
// };



import db from '../config/db.js'; // Ensure the .js extension is included
import vader from 'vader-sentiment'; // Import the vader-sentiment package

// Function to analyze sentiment
function analyzeSentiment(issue_description) {
    const sentimentResult = vader.SentimentIntensityAnalyzer.polarity_scores(issue_description);
    const polarity = sentimentResult.compound;  // Compound score: -1 (negative) to 1 (positive)

    if (polarity > 0.5) {
        return 'normal';  // Positive sentiment
    } else if (polarity < -0.5) {
        return 'severe';  // Negative sentiment
    } else {
        return 'mild';  // Neutral or mild sentiment
    }
}

// Get all complaints
export const getComplaints = (req, res) => {
    const query = 'SELECT * FROM complaints ORDER BY created_at DESC'; // Adjust query based on your DB schema

    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching complaints:', err);
            return res.status(500).send('Error fetching complaints');
        }
        res.render('admin', { complaints: results || [] }); // Ensure results are passed
    });
};

// Submit a complaint with sentiment analysis
export const submitComplaint = (req, res) => {
    const { name, email, student_id, department, other_department, year_level, issue_type, issue_description, contact_method, phone_number, other_contact_method } = req.body;

    // Analyze the sentiment of the issue description
    const sentiment = analyzeSentiment(issue_description);

    const query = `
        INSERT INTO complaints (name, email, student_id, department, other_department, year_level, issue_type, issue_description, contact_method, phone_number, other_contact_method, sentiment)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    db.query(query, [name, email, student_id, department, other_department, year_level, issue_type, issue_description, contact_method, phone_number, other_contact_method, sentiment], (err, result) => {
        if (err) {
            console.error('Error saving complaint:', err);
            return res.status(500).send('Error saving complaint');
        }
        res.redirect('/report?adding=true'); // Redirect to report page with success flag
    });
};


