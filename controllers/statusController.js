import db from '../config/db.js';  // Assuming `db` is an instance of SQLite3

// Update the status of a complaint
export const updateStatus = (req, res) => {
    const complaintId = req.params.id;
    const newStatus = req.body.status;

    // Validate the new status
    if (!newStatus || typeof newStatus !== 'string') {
        return res.status(400).json({ message: 'Valid status is required.' });
    }

    // Check if the complaint exists
    const selectQuery = 'SELECT * FROM complaints WHERE id = ?';
    db.get(selectQuery, [complaintId], (err, complaint) => {
        if (err) {
            return res.status(500).json({ message: 'Error fetching complaint', error: err.message });
        }

        if (!complaint) {
            return res.status(404).json({ message: 'Complaint not found' });
        }

        // Update the status
        const updateQuery = 'UPDATE complaints SET status = ? WHERE id = ?';
        db.run(updateQuery, [newStatus, complaintId], function (err) {
            if (err) {
                return res.status(500).json({ message: 'Error updating status', error: err.message });
            }

            // Check if the update affected any rows
            if (this.changes === 0) {
                return res.status(404).json({ message: 'Complaint not found or already updated' });
            }

            res.json({ message: 'Status updated successfully' });
        });
    });
};
