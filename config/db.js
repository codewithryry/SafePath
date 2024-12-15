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
const db = new sqlite3.Database('./safepath.db', (err) => {
  if (err) {
    console.error('Error opening database:', err);
  } else {
    console.log('Connected to SQLite database.');
  }
});

// Example: Create tables and insert data if they don't exist
db.serialize(() => {
  // Create the `admins` table
  db.run("CREATE TABLE IF NOT EXISTS admins (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NOT NULL, password TEXT NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, reset_token TEXT DEFAULT NULL, UNIQUE (username))");

  // Insert data into `admins` table, check if username already exists
  db.get("SELECT id FROM admins WHERE username = ?", ['guidanceoffice@gmail.com'], (err, row) => {
    if (err) {
      console.error('Error checking username:', err);
    } else if (!row) {
      // Insert data if username doesn't exist
      const insertAdmins = db.prepare("INSERT INTO admins (username, password, created_at, reset_token) VALUES (?, ?, ?, ?)");
      insertAdmins.run('guidanceoffice@gmail.com', '$2b$10$cgfN/VzcAyiBjgkXmqn0NOzL7vjMKjSWCVOQcBuCysa6yW.YnTwY2', '2024-10-25 11:38:47', 'df119308bf04067e6d8a53f340b1037a1c9385ff');
      insertAdmins.finalize();
    } else {
      console.log('Username already exists:', row);
    }
  });

  // Create the `advocacy` table
  db.run("CREATE TABLE IF NOT EXISTS advocacy (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT, goals TEXT, how_to_help TEXT, author TEXT DEFAULT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

  // Insert data into `advocacy` table
  const insertAdvocacy = db.prepare("INSERT INTO advocacy (title, description, goals, how_to_help, author, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?)");
  insertAdvocacy.run('SafePath Advocacy', 'At SafePath, we are committed to advocating for a safe and supportive environment for all students. Our mission is to raise awareness about bullying and promote resources that help students seek assistance and report incidents effectively.', '[ "Raise awareness about bullying and its impacts on mental health.", "Provide resources and support for victims of bullying.", "Encourage open communication between students and school authorities.", "Foster a culture of kindness and respect within the educational community."]', '[ "Participate in awareness campaigns and events.", "Share your story to inspire others.", "Volunteer with local organizations focused on bullying prevention.", "Spread the word about SafePath and our mission."]', 'Reymel Rey Mislang', '2024-11-17 06:28:06', '2024-11-17 06:28:06');
  insertAdvocacy.finalize();

  // Create the `complaints` table
  db.run("CREATE TABLE IF NOT EXISTS complaints (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT DEFAULT NULL, email TEXT DEFAULT NULL, student_id TEXT DEFAULT NULL, department TEXT NOT NULL, issue_type TEXT NOT NULL, issue_description TEXT NOT NULL, contact_method TEXT NOT NULL, phone_number TEXT DEFAULT NULL, other_department TEXT DEFAULT NULL, other_contact_method TEXT DEFAULT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, status TEXT DEFAULT 'pending', severity TEXT DEFAULT NULL, year_level TEXT DEFAULT NULL, sentiment TEXT NOT NULL DEFAULT 'normal', accuracy REAL NOT NULL DEFAULT 0, Role TEXT NOT NULL DEFAULT 'User')");

  // Insert data into `complaints` table
  const insertComplaints = db.prepare("INSERT INTO complaints (name, email, student_id, department, issue_type, issue_description, contact_method, phone_number, other_department, other_contact_method, created_at, status, severity, year_level, sentiment, accuracy, Role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
  insertComplaints.finalize();

// Function to check if question_hash exists
const checkIfFaqExists = (question_hash, callback) => {
    db.get("SELECT id FROM faqs WHERE question_hash = ?", [question_hash], (err, row) => {
      if (err) {
        console.error('Error checking question_hash:', err);
        return callback(err);
      }
      callback(null, row); // If row exists, it means question_hash already exists
    });
  };
  
  // Modified insertFaqs logic
  const insertFaq = (question, answer, question_hash) => {
    checkIfFaqExists(question_hash, (err, row) => {
      if (err) {
        console.error('Error checking question hash:', err);
      } else if (row) {
        console.log('Question hash already exists:', row);
      } else {
        const insertFaqs = db.prepare("INSERT INTO faqs (question, answer, question_hash) VALUES (?, ?, ?)");
        insertFaqs.run(question, answer, question_hash, (err) => {
          if (err) {
            console.error('Error inserting FAQ:', err);
          } else {
            console.log('FAQ inserted successfully');
          }
        });
        insertFaqs.finalize();
      }
    });
  };
  
  // Example usage
  insertFaq('What is SafePath?', 'SafePath is a platform that allows students to anonymously report bullying incidents and receive support through our integrated chatbot.', 'ea9242fc850808a240a2739c2ec46dbd');
  

  // Create the `feedback` table
  db.run("CREATE TABLE IF NOT EXISTS feedback (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT DEFAULT NULL, email TEXT DEFAULT NULL, feedback TEXT NOT NULL, rating INTEGER DEFAULT NULL, suggestions TEXT, recommend TEXT NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, department TEXT DEFAULT NULL)");

  // Insert data into `feedback` table
  const insertFeedback = db.prepare("INSERT INTO feedback (name, email, feedback, rating, suggestions, recommend, created_at, department) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
  insertFeedback.finalize();

  // Create the `why_we_are_here` table
  db.run("CREATE TABLE IF NOT EXISTS why_we_are_here (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT DEFAULT NULL, paragraph1 TEXT, paragraph2 TEXT, paragraph3 TEXT, video_link TEXT DEFAULT NULL)");

  // Insert data into `why_we_are_here` table
  const insertWhyWeAreHere = db.prepare("INSERT INTO why_we_are_here (title, paragraph1, paragraph2, paragraph3, video_link) VALUES (?, ?, ?, ?, ?)");
  insertWhyWeAreHere.run('Why We Are Here', 'SafePath provides a secure platform for students to report bullying incidents and seek support. Our goal is to create a safe, inclusive environment where every student feels protected and heard.\n', 'Bullying can lead to serious mental health issues, including anxiety, depression, and even suicide. By understanding its impact, we can work together to build a culture of empathy and safety.', 'Watch the video below to learn more about the effects of bullying and how we can combat it.', 'https://www.youtube.com/embed/YyDJafzuUK4');
  insertWhyWeAreHere.finalize();
});

export default db;
