import express from 'express';
import { submitComplaint } from '../controllers/reportController.js';

const router = express.Router();
router.post('/submit-complaint', submitComplaint);

export default router;

