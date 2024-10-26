// routes/index.js
import express from 'express';
const router = express.Router();

router.get('/', (req, res) => {
    res.render('index'); 
});

router.get('/report',  (req, res) =>{
    res.render('report'); 
});

router.get('/dashboard', (req, res) => {
    res.render('dashboard');
});

router.get('/user/feedback', (req, res) => {
    res.render('feedback'); 
});


router.get('/advocacy', (req, res) => {
    res.render('advocacy'); 
});

router.get('/admin/login', (req, res) => {
    res.render('login');
});

export default router;