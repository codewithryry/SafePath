// routes/auth.js
import express from 'express';
import bcrypt from 'bcrypt';
import db from '../config/db.js';
import nodemailer from 'nodemailer';
import crypto from 'crypto';

const router = express.Router();

// Function to send password reset email
async function sendResetEmail(email, token) {
    const transporter = nodemailer.createTransport({
        host: 'localhost', // smtp4dev runs on localhost
        port: 25, // Default SMTP port for smtp4dev
        secure: false, // false for other ports
        tls: { rejectUnauthorized: false } // Allow self-signed certificates
    });

    const resetLink = `http://localhost:3000/auth/reset-password/${token}`;
    const mailOptions = {
        from: process.env.EMAIL_USER,
        to: email,
        subject: 'Password Reset',
        html: `You requested a password reset. Click the link to reset your password: <a href="${resetLink}">${resetLink}</a>`
    };

    await transporter.sendMail(mailOptions);
}


// Route to handle forgot password
router.post('/forgot-password', async (req, res) => {
    const { email } = req.body;
    // Generate a password reset token
    const token = crypto.randomBytes(20).toString('hex');
    // Update user with the reset token
    const query = 'UPDATE admins SET reset_token = ? WHERE username = ?';
    db.query(query, [token, email], async (err, results) => {
        if (err) {
            return res.render('forgot-password', { error: 'Database error. Please try again.' });
        }
        if (results.affectedRows === 0) {
            return res.render('forgot-password', { error: 'No user found with that email.' });
        }
        // Send the reset email
        try {
            await sendResetEmail(email, token);
            res.redirect('/auth/forgot-password?success=true'); // Redirect after sending email
        } catch (emailErr) {
            return res.render('forgot-password', { error: 'Failed to send reset email. Please try again.' });
        }
    });
});


// Admin Signup Route
router.post('/signup', async (req, res) => {
    const { username, password } = req.body;
    try {
        // Hash the password
        const hashedPassword = await bcrypt.hash(password, 10);
        const query = 'INSERT INTO admins (username, password) VALUES (?, ?)';
        db.query(query, [username, hashedPassword], (err, results) => {
            if (err) {
                if (err.code === 'ER_DUP_ENTRY') {
                    return res.status(400).send('Username already exists.');
                }
                return res.status(500).send('Database error.');
            }
            res.redirect('/admin/login?added=true'); // Redirect on success
        });
    } catch (error) {
        res.status(500).send('Error signing up');
    }
});


// Route to handle password reset
router.post('/reset-password', async (req, res) => {
    const { token, password } = req.body;

    try {
        // Find user by token
        const query = 'SELECT * FROM admins WHERE reset_token = ?';
        db.query(query, [token], async (err, results) => {
            if (err) return res.status(500).send('Database error.');
            if (results.length === 0) return res.status(400).send('Invalid token.');
            const user = results[0];
            const hashedPassword = await bcrypt.hash(password, 10);
            const updateQuery = 'UPDATE admins SET password = ?, reset_token = NULL WHERE id = ?';
            db.query(updateQuery, [hashedPassword, user.id], (err) => {
                if (err) return res.status(500).send('Database error.');
                res.redirect('/admin/login?reset=success'); // Redirect after password reset
            });
        });
    } catch (error) {
        res.status(500).send('Error resetting password');
    }
});

// Route to render the forgot password page
router.get('/forgot-password', (req, res) => {
    const successMessage = req.query.success === 'true' ? 'Password reset link sent to your email.' : null;
    res.render('forgot-password', { successMessage }); // Render the view with the success message
});

// Route to display reset password form
router.get('/reset-password/:token', (req, res) => {
    const { token } = req.params;
    res.render('reset-password', { token }); // Render the reset password form with the token
});

export default router;