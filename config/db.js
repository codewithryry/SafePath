// import mysql from 'mysql2';

// // MySQL database connection setup
// const db = mysql.createConnection({
//     host: 'localhost',
//     user: 'root',
//     password: '',
//     database: 'safepath'
// });

// // Connect to MySQL
// db.connect((err) => {
//     if (err) throw err;
//     console.log('Connected to MySQL Database.');
// });


// // Export the database connection using ES module syntax
// export default db;
import sqlite3 from 'sqlite3';
sqlite3.verbose();

// Create or open the SQLite database file
const db = new sqlite3.Database('./data/safepath.db', (err) => {
  if (err) {
    console.error('Error opening database:', err);
  } else {
    console.log('Connected to SQLite database.');
  }
});

db.serialize(() => {
  // Create tables if not already existing
  const createTables = [
    `CREATE TABLE IF NOT EXISTS admins (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NOT NULL, password TEXT NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, reset_token TEXT DEFAULT NULL, UNIQUE (username))`,
    `CREATE TABLE IF NOT EXISTS advocacy (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT, goals TEXT, how_to_help TEXT, author TEXT DEFAULT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)`,
    `CREATE TABLE IF NOT EXISTS complaints (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT DEFAULT NULL, email TEXT DEFAULT NULL, student_id TEXT DEFAULT NULL, department TEXT NOT NULL, issue_type TEXT NOT NULL, issue_description TEXT NOT NULL, contact_method TEXT NOT NULL, phone_number TEXT DEFAULT NULL, other_department TEXT DEFAULT NULL, other_contact_method TEXT DEFAULT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, status TEXT DEFAULT 'pending', severity TEXT DEFAULT NULL, year_level TEXT DEFAULT NULL, sentiment TEXT NOT NULL DEFAULT 'normal', accuracy REAL NOT NULL DEFAULT 0, Role TEXT NOT NULL DEFAULT 'User')`,
    `CREATE TABLE IF NOT EXISTS feedback (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT DEFAULT NULL, email TEXT DEFAULT NULL, feedback TEXT NOT NULL, rating INTEGER DEFAULT NULL, suggestions TEXT, recommend TEXT NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, department TEXT DEFAULT NULL)`,
    `CREATE TABLE IF NOT EXISTS why_we_are_here (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT DEFAULT NULL, paragraph1 TEXT, paragraph2 TEXT, paragraph3 TEXT, video_link TEXT DEFAULT NULL)`,
    `CREATE TABLE IF NOT EXISTS faqs (id INTEGER PRIMARY KEY AUTOINCREMENT, question TEXT NOT NULL, answer TEXT NOT NULL, question_hash TEXT NOT NULL UNIQUE)`
  ];

  createTables.forEach(table => {
    db.run(table, (err) => {
      if (err) console.error('Error creating table:', err);
    });
  });

  // Function to check if data already exists in a table
  const checkIfDataExists = (table, column, value, callback) => {
    db.get(`SELECT id FROM ${table} WHERE ${column} = ?`, [value], (err, row) => {
      if (err) {
        console.error(`Error checking ${column}:`, err);
        return callback(err);
      }
      callback(null, row); // If row exists, data already exists
    });
  };

  // Insert FAQ data only if it doesn't exist
  const insertFaq = (question, answer, question_hash) => {
    checkIfDataExists('faqs', 'question_hash', question_hash, (err, row) => {
      if (err) {
        // console.error('Error checking FAQ hash:', err);
      } else if (row) {
        // console.log('FAQ already exists:', row); // Data already exists, skip insertion
      } else {
        const insertFaqs = db.prepare("INSERT INTO faqs (question, answer, question_hash) VALUES (?, ?, ?)");
        insertFaqs.run(question, answer, question_hash, (err) => {
          if (err) {
            // console.error('Error inserting FAQ:', err);
          } else {
            // console.log('FAQ inserted successfully');
          }
        });
        insertFaqs.finalize();
      }
    });
  };

  // Insert FAQs related to SafePath only if not already present
  insertFaq('What is SafePath?', 'SafePath is a platform that allows students to anonymously report bullying incidents and receive support through our integrated chatbot.', 'ea9242fc850808a240a2739c2ec46dbd');
  insertFaq('How do I report bullying on SafePath?', 'You can report bullying anonymously through our website by filling out the complaint form or using the chatbot for assistance.', 'fe1d2f47a039eabc5792279f21d73f4b');
  insertFaq('Can I report bullying on behalf of someone else?', 'Yes, you can report bullying incidents on behalf of others, while keeping their identity confidential.', '5b42b5e6c39492988f06c0701d5cb587');
  insertFaq('What happens after I submit a complaint?', 'Once a complaint is submitted, it is reviewed by our team, and necessary actions will be taken to address the issue. You will receive support and follow-up as needed.', '7c028b21512f47038f4ab1a3a2ba7b98');
  insertFaq('Is my identity protected when I report an incident?', 'Yes, your identity is kept confidential when reporting an incident, ensuring you are protected from any retaliation.', '36a7953a8f8bb7c1c9648b3d022a7b7d');
  insertFaq('How do I use the chatbot?', 'Our chatbot is designed to provide supportive responses and guidance. Simply ask a question, and the chatbot will offer advice based on the severity of the situation.', 'fb8a44e83a8a4ea39c8b8ef264c81ff3');
  insertFaq('What types of issues can I report?', 'You can report any form of bullying, harassment, discrimination, or safety concerns. Our goal is to ensure a safe and supportive environment for all students.', 'a62bfc3074f94cc8b77fc75a8d5b7a28');

  // Insert 'Why We Are Here' data only if not already present
  const insertWhyWeAreHere = (title, paragraph1, paragraph2, paragraph3, video_link) => {
    checkIfDataExists('why_we_are_here', 'title', title, (err, row) => {
      if (err) {
        // console.error('Error checking existing Why We Are Here data:', err);
      } else if (row) {
        // console.log('Why We Are Here data already exists:', row); // Data already exists, skip insertion
      } else {
        const insertData = db.prepare("INSERT INTO why_we_are_here (title, paragraph1, paragraph2, paragraph3, video_link) VALUES (?, ?, ?, ?, ?)");
        insertData.run(title, paragraph1, paragraph2, paragraph3, video_link, (err) => {
          if (err) {
            // console.error('Error inserting Why We Are Here data:', err);
          } else {
            // console.log('Why We Are Here data inserted successfully.');
          }
        });
        insertData.finalize();
      }
    });
  };

  // Insert 'Why We Are Here' data only if not already present
  insertWhyWeAreHere(
    'Why We Are Here',
    'SafePath provides a secure platform for students to report bullying incidents and seek support. Our goal is to create a safe, inclusive environment where every student feels protected and heard.',
    'Bullying can lead to serious mental health issues, including anxiety, depression, and even suicide. By understanding its impact, we can work together to build a culture of empathy and safety.',
    'Watch the video below to learn more about the effects of bullying and how we can combat it.',
    'https://www.youtube.com/embed/YyDJafzuUK4'
  );
});

export default db;

