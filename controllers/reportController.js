// import db from '../config/db.js'; // Ensure the .js extension is included
// import vader from 'vader-sentiment'; // Import the vader-sentiment package
// import nodemailer from 'nodemailer'; // Email sending package

// // // Function to analyze sentiment
// // function analyzeSentiment(issue_description) {
// //     const sentimentResult = vader.SentimentIntensityAnalyzer.polarity_scores(issue_description);
// //     const polarity = sentimentResult.compound;  // Compound score: -1 (negative) to 1 (positive)

// //     if (polarity > 0.5) {
// //         return 'normal';  // Positive sentiment
// //     } else if (polarity < -0.5) {
// //         return 'severe';  // Negative sentiment
// //     } else {
// //         return 'mild';  // Neutral or mild sentiment
// //     }
// // }


// // Function to analyze sentiment and calculate accuracy
// function analyzeSentiment(issue_description) {
//     const sentimentResult = vader.SentimentIntensityAnalyzer.polarity_scores(issue_description);
//     const polarity = sentimentResult.compound;  // Compound score: -1 (negative) to 1 (positive)
//     const accuracy = Math.abs(polarity);  // The accuracy can be derived from the magnitude of the sentiment polarity score.

//     console.log(`Sentiment Analysis for Issue Description: ${issue_description}`);
//     console.log(`Polarity: ${polarity}, Accuracy (based on sentiment): ${accuracy}`);

//     if (polarity > 0.5) {
//         return { sentiment: 'normal', accuracy };  // Positive sentiment
//     } else if (polarity < -0.5) {
//         return { sentiment: 'severe', accuracy };  // Strongly negative sentiment
//     } else {
//         return { sentiment: 'mild', accuracy };  // Neutral or weakly negative sentiment
//     }
// }

// // Get all complaints
// export const getComplaints = (req, res) => {
//     const query = 'SELECT * FROM complaints ORDER BY created_at DESC'; // Adjust query based on your DB schema

//     db.query(query, (err, results) => {
//         if (err) {
//             console.error('Error fetching complaints:', err);
//             return res.status(500).send('Error fetching complaints');
//         }
//         res.render('admin', { complaints: results || [] }); // Ensure results are passed
//     });
// };

// // Submit a complaint with sentiment analysis
// export const submitComplaint = (req, res) => {
//     const { 
//         name, 
//         email, 
//         student_id, 
//         department, 
//         other_department, 
//         year_level, 
//         issue_type, 
//         issue_description, 
//         contact_method, 
//         phone_number, 
//         other_contact_method 
//     } = req.body;

//     // Analyze the sentiment of the issue description and get accuracy
//     const { sentiment, accuracy } = analyzeSentiment(issue_description);

//     const query = `
//         INSERT INTO complaints (
//             name, email, student_id, department, other_department, year_level, 
//             issue_type, issue_description, contact_method, phone_number, 
//             other_contact_method, sentiment, accuracy
//         )
//         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
//     `;

//     db.query(query, [
//         name, email, student_id, department, other_department, year_level, 
//         issue_type, issue_description, contact_method, phone_number, 
//         other_contact_method, sentiment, accuracy
//     ], (err, result) => {
//         if (err) {
//             console.error('Error saving complaint:', err);
//             return res.status(500).send('Error saving complaint');
//         }

//         // Log the complaint details and sentiment analysis
//         console.log(`Complaint submitted by: ${name}, Sentiment: ${sentiment}, Accuracy: ${accuracy}`);

//         // Send email confirmation after successfully saving complaint
//         sendComplaintEmail(email, req.body);

//         // Redirect to report page with success flag
//         res.redirect('/report?adding=true');
//     });
// };


// // Function to send email after complaint submission
// const sendComplaintEmail = (email, complaintDetails) => {
//     // Create the transporter with Gmail SMTP configuration
//     const transporter = nodemailer.createTransport({
//         host: 'smtp.gmail.com',
//         port: 587,
//         secure: false, // Use startTLS (not secure=true, which is for SSL)
//         auth: {
//             user: process.env.EMAIL_USER,  // Should be your Gmail address
//             pass: process.env.EMAIL_PASS,  // Should be your Gmail password or App Password
//         },
//     });
    

//     // Define the email options (e.g., to, from, subject, text)
//     const mailOptions = {
//         from: process.env.EMAIL_USER,  // Sender email address
//         to: email,                     // Receiver email address
//         subject: 'Complaint Report Confirmation',  // Subject of the email
//         text: `Good Day ${complaintDetails.name} ,

// Thank you for submitting your complaint. Here are the details:

// Name: ${complaintDetails.name}
// Email: ${complaintDetails.email}
// Student ID: ${complaintDetails.student_id}
// Department: ${complaintDetails.department}
// Year Level: ${complaintDetails.year_level}
// Issue: ${complaintDetails.issue_type}
// Report Description: ${complaintDetails.issue_description}
// Preferred Contact Method: ${complaintDetails.contact_method}

// We will review your complaint and get back to you soon.


// Best regards,
// SafePath Team`,
//  };

//     // Send the email using the transporter
//     transporter.sendMail(mailOptions, (err, info) => {
//         if (err) {
//             console.error('Error sending email:', err);
//         } else {
//             console.log('Email sent: ' + info.response);
//         }
//     });
// };

















// import db from '../config/db.js'; // Ensure the .js extension is included
// import vader from 'vader-sentiment'; // Import the vader-sentiment package

// // Function to analyze sentiment
// function analyzeSentiment(issue_description) {
//     const sentimentResult = vader.SentimentIntensityAnalyzer.polarity_scores(issue_description);
//     const polarity = sentimentResult.compound;  // Compound score: -1 (negative) to 1 (positive)

//     if (polarity > 0.5) {
//         return 'normal';  // Positive sentiment
//     } else if (polarity < -0.5) {
//         return 'severe';  // Negative sentiment
//     } else {
//         return 'mild';  // Neutral or mild sentiment
//     }
// }

// // Get all complaints
// export const getComplaints = (req, res) => {
//     const query = 'SELECT * FROM complaints ORDER BY created_at DESC'; // Adjust query based on your DB schema

//     db.query(query, (err, results) => {
//         if (err) {
//             console.error('Error fetching complaints:', err);
//             return res.status(500).send('Error fetching complaints');
//         }
//         res.render('admin', { complaints: results || [] }); // Ensure results are passed
//     });
// };

// // Submit a complaint with sentiment analysis
// export const submitComplaint = (req, res) => {
//     const { name, email, student_id, department, other_department, year_level, issue_type, issue_description, contact_method, phone_number, other_contact_method } = req.body;

//     // Analyze the sentiment of the issue description
//     const sentiment = analyzeSentiment(issue_description);

//     const query = `
//         INSERT INTO complaints (name, email, student_id, department, other_department, year_level, issue_type, issue_description, contact_method, phone_number, other_contact_method, sentiment)
//         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
//     `;

//     db.query(query, [name, email, student_id, department, other_department, year_level, issue_type, issue_description, contact_method, phone_number, other_contact_method, sentiment], (err, result) => {
//         if (err) {
//             console.error('Error saving complaint:', err);
//             return res.status(500).send('Error saving complaint');
//         }
//         res.redirect('/report?adding=true'); // Redirect to report page with success flag
//     });
// };












// import db from '../config/db.js'; // Ensure the .js extension is included


// // Get all complaints
// export const getComplaints = (req, res) => {
//     const query = 'SELECT * FROM complaints ORDER BY created_at DESC'; // Adjust query based on your DB schema

//     db.query(query, (err, results) => {
//         if (err) {
//             console.error('Error fetching complaints:', err);
//             return res.status(500).send('Error fetching complaints');
//         }
//       //  console.log('Fetched complaints:', results); // Log the results for debugging
//         res.render('admin', { complaints: results || [] }); // Ensure results are passed
//     });
// };

// export const submitComplaint = (req, res) => {
//     const { name, email, student_id, department, other_department, year_level, issue_type, issue_description, contact_method, phone_number, other_contact_method } = req.body;

//     const query = `
//         INSERT INTO complaints (name, email, student_id, department, other_department, year_level, issue_type, issue_description, contact_method, phone_number, other_contact_method)
//         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
//     `;

//     db.query(query, [name, email, student_id, department, other_department, year_level, issue_type, issue_description, contact_method, phone_number, other_contact_method], (err, result) => {
//         if (err) {
//             console.error('Error saving complaint:', err);
//             return res.status(500).send('Error saving complaint');
//         }
//         res.redirect('/report?adding=true'); // Redirect to report page with success flag
//     });
// };










import db from '../config/db.js'; // Ensure SQLite DB connection
import vader from 'vader-sentiment'; // Import the vader-sentiment package
import nodemailer from 'nodemailer'; // Email sending package

// Function to analyze sentiment and calculate accuracy
function analyzeSentiment(issue_description) {
    const sentimentResult = vader.SentimentIntensityAnalyzer.polarity_scores(issue_description);
    const polarity = sentimentResult.compound;  // Compound score: -1 (negative) to 1 (positive)
    const accuracy = Math.abs(polarity);  // The accuracy can be derived from the magnitude of the sentiment polarity score.

    console.log(`Sentiment Analysis for Issue Description: ${issue_description}`);
    console.log(`Polarity: ${polarity}, Accuracy (based on sentiment): ${accuracy}`);

    if (polarity > 0.5) {
        return { sentiment: 'normal', accuracy };  // Positive sentiment
    } else if (polarity < -0.5) {
        return { sentiment: 'severe', accuracy };  // Strongly negative sentiment
    } else {
        return { sentiment: 'mild', accuracy };  // Neutral or weakly negative sentiment
    }
}

// Get all complaints
export const getComplaints = (req, res) => {
    const query = 'SELECT * FROM complaints ORDER BY created_at DESC'; // Adjust query based on your DB schema

    db.all(query, (err, results) => {
        if (err) {
            console.error('Error fetching complaints:', err);
            return res.status(500).send('Error fetching complaints');
        }
        res.render('admin', { complaints: results || [] }); // Ensure results are passed
    });
};

// Submit a complaint with sentiment analysis
export const submitComplaint = (req, res) => {
    const { 
        name, 
        email, 
        student_id, 
        department, 
        other_department, 
        year_level, 
        issue_type, 
        issue_description, 
        contact_method, 
        phone_number, 
        other_contact_method 
    } = req.body;

    // Analyze the sentiment of the issue description and get accuracy
    const { sentiment, accuracy } = analyzeSentiment(issue_description);

    const query = `
        INSERT INTO complaints (
            name, email, student_id, department, other_department, year_level, 
            issue_type, issue_description, contact_method, phone_number, 
            other_contact_method, sentiment, accuracy
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    db.run(query, [
        name, email, student_id, department, other_department, year_level, 
        issue_type, issue_description, contact_method, phone_number, 
        other_contact_method, sentiment, accuracy
    ], function (err) {
        if (err) {
            console.error('Error saving complaint:', err);
            return res.status(500).send('Error saving complaint');
        }

        // Log the complaint details and sentiment analysis
        console.log(`Complaint submitted by: ${name}, Sentiment: ${sentiment}, Accuracy: ${accuracy}`);

        // Send email confirmation after successfully saving complaint
        sendComplaintEmail(email, req.body);

        // Redirect to report page with success flag
        res.redirect('/report?adding=true');
    });
};

// Function to send email after complaint submission
const sendComplaintEmail = (email, complaintDetails) => {
    // Create the transporter with Gmail SMTP configuration
    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure: false, // Use startTLS (not secure=true, which is for SSL)
        auth: {
            user: process.env.EMAIL_USER,  // Should be your Gmail address
            pass: process.env.EMAIL_PASS,  // Should be your Gmail password or App Password
        },
    });

    // Define the email options (e.g., to, from, subject, text)
    const mailOptions = {
        from: process.env.EMAIL_USER,  // Sender email address
        to: email,                     // Receiver email address
        subject: 'Complaint Report Confirmation',  // Subject of the email
        text: `Good Day ${complaintDetails.name} ,

Thank you for submitting your complaint. Here are the details:

Name: ${complaintDetails.name}
Email: ${complaintDetails.email}
Student ID: ${complaintDetails.student_id}
Department: ${complaintDetails.department}
Year Level: ${complaintDetails.year_level}
Issue: ${complaintDetails.issue_type}
Report Description: ${complaintDetails.issue_description}
Preferred Contact Method: ${complaintDetails.contact_method}

We will review your complaint and get back to you soon.

Best regards,
SafePath Team`,
    };

    // Send the email using the transporter
    transporter.sendMail(mailOptions, (err, info) => {
        if (err) {
            console.error('Error sending email:', err);
        } else {
            console.log('Email sent: ' + info.response);
        }
    });
};
