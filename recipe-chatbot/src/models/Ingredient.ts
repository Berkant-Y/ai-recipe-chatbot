export class Ingredient {
    id: string;
    name: string;
    quantity: string;

    constructor(id: string, name: string, quantity: string) {
        this.id = id;
        this.name = name;
        this.quantity = quantity;
    }
}