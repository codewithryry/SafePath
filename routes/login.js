import express from 'express';

const router = express.Router(); 

router.get('/admin/login', (req, res) => {
    res.render('login'); 
});

router.post('/admin/login', (req, res) => {
    const { username, password } = req.body;
    console.log('Login attempt:', { username, password });

    res.redirect('/admin/dashboard');
});

export default router; 
