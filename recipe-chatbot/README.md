# Recipe Chatbot

This project is a chatbot application that suggests recipes based on ingredients provided by the user. It utilizes a Large Language Model (LLM) for generating recipe suggestions and integrates with Firebase for database management.

## Features

- **Ingredient-Based Recipe Suggestions**: Users can input ingredients, and the chatbot will suggest recipes that include those ingredients.
- **Recipe Management**: Users can fetch and add recipes to the Firebase database.
- **Authentication**: Middleware is included to ensure that only authorized users can access certain routes.

## Project Structure

```
recipe-chatbot
├── src
│   ├── app.ts                # Entry point of the application
│   ├── controllers           # Contains controllers for handling requests
│   │   ├── chatbot.ts        # Chatbot controller for user input
│   │   └── recipes.ts        # Recipes controller for managing recipes
│   ├── services              # Contains services for business logic
│   │   ├── llm.ts           # Service for interacting with the LLM API
│   │   ├── firebase.ts       # Service for Firebase interactions
│   │   └── recipeService.ts  # Service for recipe-related logic
│   ├── models                # Contains data models
│   │   ├── Recipe.ts         # Recipe model
│   │   └── Ingredient.ts     # Ingredient model
│   ├── routes                # Contains route definitions
│   │   ├── chat.ts           # Routes for chatbot functionality
│   │   └── recipes.ts        # Routes for recipe management
│   ├── middleware            # Contains middleware functions
│   │   └── auth.ts           # Authentication middleware
│   ├── config                # Configuration files
│   │   ├── firebase.ts       # Firebase configuration
│   │   └── llm.ts            # LLM configuration
│   └── types                 # TypeScript types
│       └── index.ts          # Type definitions for Recipe and Ingredient
├── package.json              # npm configuration file
├── tsconfig.json             # TypeScript configuration file
├── .env.example              # Example environment variables
└── README.md                 # Project documentation
```

## Setup Instructions

1. **Clone the Repository**:
   ```
   git clone <repository-url>
   cd recipe-chatbot
   ```

2. **Install Dependencies**:
   ```
   npm install
   ```

3. **Configure Environment Variables**:
   - Copy `.env.example` to `.env` and fill in the required API keys and database URLs.

4. **Run the Application**:
   ```
   npm start
   ```

## Usage

- Interact with the chatbot by providing ingredients, and it will suggest recipes based on the input.
- Use the recipe management routes to fetch or add recipes to the database.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.

## License

This project is licensed under the MIT License.