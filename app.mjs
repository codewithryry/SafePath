// In app.mjs

import express from 'express';
import path from 'path';
import bodyParser from 'body-parser';
import dotenv from 'dotenv';
import session from 'express-session';
import { fileURLToPath } from 'url';


// Initialize dotenv
dotenv.config();

// Create an instance of express
const app = express();

// Set up the correct __dirname
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.use(
    session({
        secret: '83985f6710dab4693459d27b42505702f704d7ed02761503227e0f9f55e56e73',
        resave: false,
        saveUninitialized: true,
        cookie: { 
            secure: false, // Set to true if using HTTPS
            maxAge: 3600000 // 1 hour in milliseconds
        }
    })
);



// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'ejs');

// Routes
import indexRouter from './routes/index.js';
import reportRouter from './routes/report.js';
import adminRoutes from './routes/admin.js';
import loginRoutes from './routes/login.js';
import feedbackRouter from './routes/feedback.js';
import statusRouter from './routes/status.js';
import faqRouter from './routes/faqRoutes.js';
import aboutUsRouter from './routes/aboutus.js';
import authRoutes from './routes/auth.js';  // Updated to ES module import
import why_we_are_hereRouter from './routes/whyRoutes.js';


// Use Routes
app.use('/', indexRouter);
app.use('/report', reportRouter);
app.use('/admin', adminRoutes);
app.use('/', loginRoutes);
app.use('/user', feedbackRouter);
app.use('/admin/dashboard', statusRouter);
app.use('/', faqRouter);
app.use('/', why_we_are_hereRouter )
app.use('/', aboutUsRouter);
app.use('/admin', authRoutes); // Register auth routes under /admin prefix
app.use('/auth', authRoutes); // Ensure this matches your routes structure


// Placeholder for recent activities
const recentActivities = [];

// API endpoint to report a complaint
app.post('/report', (req, res) => {
    const { complaintId, studentId } = req.body;
    const activity = `New complaint submitted by Student ID ${studentId}. Complaint ID ${complaintId}.`;
    recentActivities.push(activity);
    res.send({ message: 'Complaint reported!', activities: recentActivities });
});

// API endpoint to update complaint status
app.post('/update-status', (req, res) => {
    const { complaintId, status } = req.body;
    const activity = `Complaint ID ${complaintId} status changed to ${status}.`;
    recentActivities.push(activity);
    res.send({ message: 'Status updated!', activities: recentActivities });
});


// DB query for FAQs endpoint
app.get('/faqs', (req, res) => {
    db.query('SELECT * FROM faqs', (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});


// Set the port
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});

