import db from '../config/db.js';

// Update the status of a complaint
export const updateStatus = (req, res) => {
    const complaintId = req.params.id;
    const newStatus = req.body.status;

   // console.log(`Request to update status for complaint ID: ${complaintId} with new status: ${newStatus}`);

    // Validate the new status
    if (!newStatus || typeof newStatus !== 'string') {
       // console.log('Invalid status provided');
        return res.status(400).json({ message: 'Valid status is required.' });
    }

    // Check if the complaint exists
    const selectQuery = 'SELECT * FROM complaints WHERE id = ?';
    db.query(selectQuery, [complaintId], (err, complaint) => {
        if (err) {
           // console.error('Error fetching complaint:', err);
            return res.status(500).json({ message: 'Error fetching complaint', error: err.message });
        }

        if (complaint.length === 0) {
            console.log('Complaint not found');
            return res.status(404).json({ message: 'Complaint not found' });
        }

        // Update the status
        const query = 'UPDATE complaints SET status = ? WHERE id = ?';
        db.query(query, [newStatus, complaintId], (err, results) => {
            if (err) {
                console.error('Error updating status:', err);
                return res.status(500).json({ message: 'Error updating status', error: err.message });
            }

            if (results.affectedRows === 0) {
          //      console.log('Complaint not found or already updated');
                return res.status(404).json({ message: 'Complaint not found or already updated' });
            }

          //  console.log('Status updated successfully');
            res.json({ message: 'Status updated successfully' });
        });
    });

    
};
