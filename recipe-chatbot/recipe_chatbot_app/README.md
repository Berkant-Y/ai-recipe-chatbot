# Recipe Chatbot App

## Overview
The Recipe Chatbot App is a Flutter application that integrates a Gemini chatbot to provide recipe suggestions based on user-provided ingredients. The app connects to Firebase for storing and retrieving recipes, making it easy for users to find new meal ideas.

## Features
- Chat interface powered by the Gemini chatbot for interactive recipe suggestions.
- Input field for users to enter ingredients they have on hand.
- Recipe suggestions fetched from Firebase based on user input.
- Detailed view of selected recipes, including ingredients and instructions.

## Getting Started

### Prerequisites
- Flutter SDK installed on your machine.
- Firebase project set up with Firestore enabled.
- Gemini chatbot API access.

### Installation
1. Clone the repository:
   ```
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```
   cd recipe_chatbot_app
   ```
3. Install dependencies:
   ```
   flutter pub get
   ```

### Configuration
- Update the `lib/utils/constants.dart` file with your Firebase and Gemini API keys.
- Ensure that your Firebase Firestore rules allow read access for the recipes collection.

### Running the App
To run the app, use the following command:
```
flutter run
```

## Usage
- Launch the app and navigate to the home screen.
- Enter the ingredients you have in the input field.
- Tap the submit button to receive recipe suggestions from the chatbot.
- Click on a recipe to view its details.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.

## License
This project is licensed under the MIT License. See the LICENSE file for details.