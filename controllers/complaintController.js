// Import necessary modules
import db from '../config/db.js';

export const getComplaintsByYearLevel = (req, res) => {
    const query = `
        SELECT year_level, COUNT(*) AS complaint_count
        FROM complaints
        GROUP BY year_level
        ORDER BY year_level
    `;
    

    db.query(query, (err, results) => {
        if (err) {
            console.error('Error fetching complaints by year level:', err);
            return res.status(500).send('Error fetching data');
        }
        
        res.json(results); // Send the results as JSON
    });
};
