import express from 'express';
import { updateStatus } from '../controllers/statusController.js';

const router = express.Router();
router.post('/update-status/:id', updateStatus);

export default router;