import db from '../config/db.js'; // Ensure the .js extension is included


// Get all complaints
export const getComplaints = (req, res) => {
    const query = 'SELECT * FROM complaints ORDER BY created_at DESC'; // Adjust query based on your DB schema

    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching complaints:', err);
            return res.status(500).send('Error fetching complaints');
        }
      //  console.log('Fetched complaints:', results); // Log the results for debugging
        res.render('admin', { complaints: results || [] }); // Ensure results are passed
    });
};

export const submitComplaint = (req, res) => {
    const { name, email, student_id, department, other_department, year_level, issue_type, issue_description, contact_method, phone_number, other_contact_method } = req.body;

    const query = `
        INSERT INTO complaints (name, email, student_id, department, other_department, year_level, issue_type, issue_description, contact_method, phone_number, other_contact_method)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    db.query(query, [name, email, student_id, department, other_department, year_level, issue_type, issue_description, contact_method, phone_number, other_contact_method], (err, result) => {
        if (err) {
            console.error('Error saving complaint:', err);
            return res.status(500).send('Error saving complaint');
        }
        res.redirect('/report?adding=true'); // Redirect to report page with success flag
    });
};


