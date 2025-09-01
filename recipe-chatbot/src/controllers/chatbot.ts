class ChatbotController {
    constructor(private llmService: any, private recipeService: any) {}

    async handleUserInput(ingredients: string[]): Promise<string[]> {
        const recipes = await this.llmService.callLLM(ingredients);
        return recipes;
    }
}

export default ChatbotController;