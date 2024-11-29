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


// PUT (Update) an FAQ
router.put('/admin/dashboard/customization/faq/:id', (req, res) => {
    const { id } = req.params;
    const { question, answer } = req.body;

    if (!question || !answer) {
        return res.status(400).json({ error: 'Question and answer are required' });
    }

    db.query(
        'UPDATE faqs SET question = ?, answer = ? WHERE id = ?',
        [question, answer, id],
        (err, results) => {
            if (err) {
                console.error('Error updating FAQ:', err);
                return res.status(500).json({ error: 'Internal server error' });
            }

            if (results.affectedRows === 0) {
                return res.status(404).json({ error: 'FAQ not found' });
            }

            res.json({ message: 'FAQ updated successfully!' });
        }
    );
});

// DELETE an FAQ
router.delete('/admin/dashboard/customization/faq/:id', (req, res) => {
    const { id } = req.params;

    db.query('DELETE FROM faqs WHERE id = ?', [id], (err, results) => {
        if (err) {
            console.error('Error deleting FAQ:', err);
            return res.status(500).json({ error: 'Internal server error' });
        }

        if (results.affectedRows === 0) {
            return res.status(404).json({ error: 'FAQ not found' });
        }

        res.json({ message: 'FAQ deleted successfully!' });
    });
});

export default router;
