import express from 'express';
import { isAuthenticated } from '../middlewares/authMiddleware.js'; // Importing the middleware

const router = express.Router(); 

// Route for login page
router.get('/admin/login', (req, res) => {
    res.render('login'); 
});

// Route for handling login form submission
router.post('/admin/login', (req, res) => {
    const { username, password } = req.body;

    // Simulate credential verification (replace with actual verification logic)
    if (username === 'guidanceoffice@gmail.com' && password === 'guidanceoffice') {
        req.session.isAuthenticated = true; // Set session as authenticated
        res.redirect('/admin/dashboard');
    } else {
        res.render('login', { message: 'Invalid credentials' });
    }
});


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



// Export the router
export default router; 
