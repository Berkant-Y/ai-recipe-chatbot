import { Router } from 'express';
import RecipesController from '../controllers/recipes';

const router = Router();
const recipesController = new RecipesController();

export function setRecipeRoutes(app) {
    app.use('/api/recipes', router);
    
    router.get('/', recipesController.getRecipes.bind(recipesController));
    router.post('/', recipesController.addRecipe.bind(recipesController));
}