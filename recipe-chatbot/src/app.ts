import express from 'express';
import { json } from 'body-parser';
import { setChatRoutes } from './routes/chat';
import { setRecipeRoutes } from './routes/recipes';
import { initializeFirebase } from './services/firebase';

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(json());

// Initialize Firebase
initializeFirebase();

// Routes
setChatRoutes(app);
setRecipeRoutes(app);

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});