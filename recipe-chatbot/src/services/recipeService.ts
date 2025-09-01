import { Recipe } from '../models/Recipe';
import { getRecipesFromFirebase, saveRecipeToFirebase } from './firebase';

export const fetchRecipes = async (ingredients: string[]): Promise<Recipe[]> => {
    const allRecipes = await getRecipesFromFirebase();
    return allRecipes.filter((recipe: Recipe) => 
        Array.isArray(recipe.ingredients) &&
        ingredients.every(ingredient => recipe.ingredients.includes(ingredient))
    );
};

export const saveRecipe = async (recipe: Recipe): Promise<void> => {
    await saveRecipeToFirebase(recipe);
};