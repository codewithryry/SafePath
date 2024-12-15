// import express from 'express';
// import db from '../config/db.js';



// const router = express.Router();


// // GET the "Why We Are Here" section
// router.get('/admin/dashboard/customization/why-we-are-here', (req, res) => {
//     db.query('SELECT * FROM why_we_are_here WHERE id = 1', (error, result) => {
//         if (error) {
//             console.error('Error fetching Why We Are Here section:', error);
//             return res.status(500).json({ error: 'Internal server error' });
//         }
//         if (result.length === 0) {
//             return res.status(404).json({ error: 'Section not found' });
//         }
//         res.json(result[0]); // Send the first (and only) entry
//     });
// });


// // POST to update the "Why We Are Here" section
// router.post('/admin/dashboard/customization/why-we-are-here', (req, res) => {
//     const { title, paragraph1, paragraph2, paragraph3, video_link } = req.body;

//     if (!title || !paragraph1 || !paragraph2 || !paragraph3 || !video_link) {
//         return res.status(400).json({ error: 'All fields are required' });
//     }

//     db.query('UPDATE why_we_are_here SET title = ?, paragraph1 = ?, paragraph2 = ?, paragraph3 = ?, video_link = ? WHERE id = 1',
//         [title, paragraph1, paragraph2, paragraph3, video_link], (err, results) => {
//             if (err) {
//                 console.error('Error updating Why We Are Here section:', err);
//                 return res.status(500).json({ error: 'Internal server error' });
//             }
//             res.json({ message: 'Section updated successfully!' });
//         });
// });




// export default router;




import express from 'express';
import db from '../config/db.js';


const router = express.Router();


// GET the "Why We Are Here" section
router.get('/admin/dashboard/customization/why-we-are-here', (req, res) => {
    db.get('SELECT * FROM why_we_are_here WHERE id = 1', (error, result) => { // Using db.get() for a single row query
        if (error) {
            console.error('Error fetching Why We Are Here section:', error);
            return res.status(500).json({ error: 'Internal server error' });
        }
        if (!result) {
            return res.status(404).json({ error: 'Section not found' });
        }
        res.json(result); // Send the result object (single row)
    });
});

// POST to update the "Why We Are Here" section
router.post('/admin/dashboard/customization/why-we-are-here', (req, res) => {
    const { title, paragraph1, paragraph2, paragraph3, video_link } = req.body;

    if (!title || !paragraph1 || !paragraph2 || !paragraph3 || !video_link) {
        return res.status(400).json({ error: 'All fields are required' });
    }

    db.run(
        'UPDATE why_we_are_here SET title = ?, paragraph1 = ?, paragraph2 = ?, paragraph3 = ?, video_link = ? WHERE id = 1',
        [title, paragraph1, paragraph2, paragraph3, video_link], 
        (err) => {
            if (err) {
                console.error('Error updating Why We Are Here section:', err);
                return res.status(500).json({ error: 'Internal server error' });
            }
            res.json({ message: 'Section updated successfully!' });
        }
    );
});

export default router;
