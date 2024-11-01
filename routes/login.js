import express from 'express';
<<<<<<< HEAD
import db from '../config/db.js';
import bcrypt from 'bcrypt';
=======
>>>>>>> 71472ebecc35c07c100a3443d13dd6e6023b9e74
import { isAuthenticated } from '../middlewares/authMiddleware.js'; // Importing the middleware

const router = express.Router(); 

// Route for login page
<<<<<<< HEAD
// Assuming you have a route for your login page
=======
>>>>>>> 71472ebecc35c07c100a3443d13dd6e6023b9e74
router.get('/admin/login', (req, res) => {
    const resetSuccess = req.query.reset === 'success' ? true : false;
    res.render('login', { resetSuccess }); // Pass resetSuccess to the login view
});

<<<<<<< HEAD

=======
// Route for handling login form submission
>>>>>>> 71472ebecc35c07c100a3443d13dd6e6023b9e74
router.post('/admin/login', (req, res) => {
    const { username, password } = req.body;

    // Query the database for the user
    const query = 'SELECT * FROM admins WHERE username = ?';
    db.query(query, [username], async (err, results) => {
        if (err) {
            return res.status(500).send('Database error.');
        }
        
        if (results.length === 0) {
            return res.render('login', { message: 'Invalid credentials' });
        }

        const user = results[0];

        // Compare the hashed password with the entered password
        const match = await bcrypt.compare(password, user.password);
        if (match) {
            req.session.isAuthenticated = true; // Set session as authenticated
            return res.redirect('/admin/dashboard');
        } else {
            return res.render('login', { message: 'Invalid credentials' });
        }
    });
});


<<<<<<< HEAD

=======
>>>>>>> 71472ebecc35c07c100a3443d13dd6e6023b9e74
router.get('/admin/logout', (req, res) => {
    res.render('login');
});

// Admin dashboard routes, protected by the isAuthenticated middleware
router.get('/admin/dashboard/feedback', isAuthenticated, (req, res) => {
    res.render('adminFeedback'); // Render feedback page
});

router.get('/admin/dashboard/customization', isAuthenticated, (req, res) => {
    res.render('adminCustomization'); // Render customization page
});

router.get('/admin/dashboard/complaints', isAuthenticated, (req, res) => {
    res.render('adminComplaints'); // Render complaints page
});


<<<<<<< HEAD
router.get('/admin/dashboard/customization/why-we-here', isAuthenticated, (req, res) => {
    res.render('adminwhy'); // Render customization page
});
=======

>>>>>>> 71472ebecc35c07c100a3443d13dd6e6023b9e74
// Export the router
export default router; 
