// import express from 'express';
// import db from '../config/db.js';

// const router = express.Router();

// // GET About Us content
// router.get('/admin/dashboard/customization/aboutus', (req, res) => {
//     db.query('SELECT * FROM about_us', (error, aboutUsContent) => {
//         if (error) {
//             console.error('Error fetching About Us content:', error);
//             return res.status(500).json({ error: 'Internal server error' });
//         }
//         res.json(aboutUsContent);
//     });
// });

// // POST a new About Us content
// router.post('/admin/dashboard/customization/aboutus', (req, res) => {
//     const { title, description, image_url, alt_text } = req.body;

//     if (!title || !description || !image_url || !alt_text) {
//         return res.status(400).json({ error: 'All fields are required' });
//     }

    
//     db.query('INSERT INTO about_us (title, description, image_url, alt_text) VALUES (?, ?, ?, ?)', 
//         [title, description, image_url, alt_text], 
//         (err, results) => {
//             if (err) {
//                 console.error('Error adding About Us content:', err);
//                 return res.status(500).json({ error: 'Internal server error' });
//             }
//             res.status(201).json({ message: 'About Us content added successfully!', id: results.insertId });
//         }
//     );
// });

// export default router;



import express from 'express';
import db from '../config/db.js'; // Import your sqlite3 database connection

const router = express.Router();

// GET About Us content
router.get('/admin/dashboard/customization/aboutus', (req, res) => {
    db.all('SELECT * FROM about_us', [], (error, aboutUsContent) => {
        if (error) {
            console.error('Error fetching About Us content:', error);
            return res.status(500).json({ error: 'Internal server error' });
        }
        res.json(aboutUsContent);
    });
});

// POST a new About Us content
router.post('/admin/dashboard/customization/aboutus', (req, res) => {
    const { title, description, image_url, alt_text } = req.body;

    if (!title || !description || !image_url || !alt_text) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    // Prepare the SQL insert statement
    const insertQuery = 'INSERT INTO about_us (title, description, image_url, alt_text) VALUES (?, ?, ?, ?)';
    
    // Run the insert query with the provided data
    db.run(insertQuery, [title, description, image_url, alt_text], function (err) {
        if (err) {
            console.error('Error adding About Us content:', err);
            return res.status(500).json({ error: 'Internal server error' });
        }
        res.status(201).json({ message: 'About Us content added successfully!', id: this.lastID });
    });
});

export default router;
