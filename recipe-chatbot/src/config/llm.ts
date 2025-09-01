export const LLM_CONFIG = {
    endpoint: process.env.LLM_API_ENDPOINT || 'https://api.example.com/llm',
    apiKey: process.env.LLM_API_KEY || 'your-api-key-here',
    timeout: 5000, // timeout in milliseconds
};