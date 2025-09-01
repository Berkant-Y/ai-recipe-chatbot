import axios from 'axios';
import { LLM_API_URL, LLM_API_KEY } from '../config/llm';

export async function callLLM(ingredients: string[]): Promise<string[]> {
    try {
        const response = await axios.post(LLM_API_URL, {
            ingredients: ingredients.join(', '),
        }, {
            headers: {
                'Authorization': `Bearer ${LLM_API_KEY}`,
                'Content-Type': 'application/json',
            },
        });

        return response.data.recipes;
    } catch (error) {
        console.error('Error calling LLM API:', error);
        throw new Error('Failed to fetch recipe suggestions');
    }
}