import { Router } from 'express';
import { ChatbotController } from '../controllers/chatbot';

const router = Router();
const chatbotController = new ChatbotController();

router.post('/chat', chatbotController.handleUserInput.bind(chatbotController));

export function setChatRoutes(app) {
    app.use('/api', router);
}