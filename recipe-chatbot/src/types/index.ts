export interface Recipe {
    id: string;
    name: string;
    ingredients: Ingredient[];
    instructions: string;
}

export interface Ingredient {
    id: string;
    name: string;
    quantity: string;
}