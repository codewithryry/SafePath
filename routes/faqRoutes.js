import express from 'express';
import db from '../config/db.js';

const router = express.Router();

// GET all FAQs
router.get('/admin/dashboard/customization/faq', (req, res) => {
    db.query('SELECT * FROM faqs', (error, faqs) => {
        if (error) {
            console.error('Error fetching FAQs:', error);
            return res.status(500).json({ error: 'Internal server error' });
        }
        res.json(faqs);
    });
});

// POST a new FAQ
router.post('/admin/dashboard/customization/faq', (req, res) => {
    const { question, answer } = req.body;
    
    if (!question || !answer) {
        return res.status(400).json({ error: 'Question and answer are required' });
    }

    db.query('INSERT INTO faqs (question, answer) VALUES (?, ?)', [question, answer], (err, results) => {
        if (err) {
            console.error('Error adding FAQ:', err);
            return res.status(500).json({ error: 'Internal server error' });
        }
        res.status(201).json({ message: 'FAQ added successfully!', id: results.insertId });
    });
});

export default router;
