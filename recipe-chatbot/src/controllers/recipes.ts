export class RecipesController {
    constructor(private recipeService: any) {}

    async getRecipes(req: any, res: any) {
        try {
            const recipes = await this.recipeService.fetchRecipes();
            res.status(200).json(recipes);
        } catch (error) {
            res.status(500).json({ message: 'Error fetching recipes', error });
        }
    }

    async addRecipe(req: any, res: any) {
        const newRecipe = req.body;
        try {
            await this.recipeService.saveRecipe(newRecipe);
            res.status(201).json({ message: 'Recipe added successfully' });
        } catch (error) {
            res.status(500).json({ message: 'Error adding recipe', error });
        }
    }
}