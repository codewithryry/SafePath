import express from 'express';

const router = express.Router(); 

router.get('/admin/login', (req, res) => {
    res.render('login'); 
});

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


export default router; 