import { db } from '../config/firebase';
import { collection, getDocs, addDoc } from 'firebase/firestore';
import { Recipe } from '../models/Recipe';

export const getRecipesFromFirebase = async (): Promise<Recipe[]> => {
    const recipesCollection = collection(db, 'recipes');
    const recipeSnapshot = await getDocs(recipesCollection);
    const recipeList: Recipe[] = recipeSnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() } as Recipe));
    return recipeList;
};

export const saveRecipeToFirebase = async (recipe: Recipe) => {
    const recipesCollection = collection(db, 'recipes');
    const docRef = await addDoc(recipesCollection, recipe);
    return docRef.id;
};