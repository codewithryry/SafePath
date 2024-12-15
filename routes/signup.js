// import express from 'express';
// import bcrypt from 'bcrypt'; // Ensure bcrypt is correctly imported
// import db from '../config/db.js';

// const router = express.Router();

// // Render the signup form
// router.get('/admin/signup', (req, res) => {
//     res.render('signup');
// });


// // Handle signup form submission
// router.post('/admin/signup', async (req, res) => {
//     const { username, password } = req.body;

//     try {
//         // Hash the password before saving
//         const hashedPassword = await bcrypt.hash(password, 10);
//    //     console.log('Generated Hashed Password:', hashedPassword); // Log to confirm hash

//         // Insert the new admin into the database
//         const query = 'INSERT INTO admins (username, password) VALUES (?, ?)';
//         db.query(query, [username, hashedPassword], (err, result) => {
//             if (err) {
//                 console.error('Database error:', err);
//                 return res.redirect('/admin/signup'); // Redirect back to signup if error occurs
//             }

//  //           console.log('New admin registered successfully!');
//             res.redirect('/admin/login'); // Redirect to login page after successful signup
//         });
//     } catch (error) {
//         console.error('Error during signup:', error);
//         res.redirect('/admin/signup'); // Redirect back to signup if error occurs
//     }
// });

// export default router;




import express from 'express';
import bcrypt from 'bcrypt'; // Ensure bcrypt is correctly imported
import db from '../config/db.js';
const router = express.Router();



// Render the signup form
router.get('/admin/signup', (req, res) => {
    res.render('signup');
});

// Handle signup form submission
router.post('/admin/signup', async (req, res) => {
    const { username, password } = req.body;

    try {
        // Hash the password before saving
        const hashedPassword = await bcrypt.hash(password, 10);

        // Insert the new admin into the database using db.run for SQLite
        const query = 'INSERT INTO admins (username, password) VALUES (?, ?)';
        db.run(query, [username, hashedPassword], function (err) {
            if (err) {
                console.error('Database error:', err);
                return res.redirect('/admin/signup'); // Redirect back to signup if error occurs
            }

            console.log('New admin registered successfully!');
            res.redirect('/admin/login'); // Redirect to login page after successful signup
        });
    } catch (error) {
        console.error('Error during signup:', error);
        res.redirect('/admin/signup'); // Redirect back to signup if error occurs
    }
});

export default router;
