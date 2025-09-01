# 🤖 AI Recipe Chatbot

AI-powered Flutter chatbot that suggests recipes based on available ingredients. Built with Gemini AI.

## 📱 Features

- **Smart Ingredient Detection**: Automatically detects Turkish ingredients from your messages
- **AI-Powered Suggestions**: Uses Google Gemini AI to generate personalized recipe recommendations
- **Interactive Chat Interface**: Clean and intuitive chat UI for seamless user experience
- **Recipe Details**: Detailed cooking instructions, ingredients list, and cooking time
- **Turkish Language Support**: Fully localized for Turkish cuisine and ingredients
- **Cross-Platform**: Runs on Android, iOS, and Web

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.8.0)
- Dart SDK
- Android Studio / VS Code
- Google Gemini API Key

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/ai-recipe-chatbot.git
   cd ai-recipe-chatbot
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up environment variables**
   
   Create a `.env` file in the root directory:
   ```env
   GEMINI_API_KEY=your_gemini_api_key_here
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🔧 Configuration

### Getting Gemini API Key

1. Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Create a new API key
3. Add it to your `.env` file

### Supported Platforms

- ✅ Android
- ✅ iOS  
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 📖 Usage

1. **Start the app** and you'll see a welcome message
2. **Type your available ingredients** in Turkish (e.g., "Elimde soğan, domates ve patates var")
3. **Get AI suggestions** - The bot will suggest recipes you can make
4. **Tap on recipes** to see detailed cooking instructions
5. **Enjoy cooking!** 🍳

### Example Conversations

```
👤 User: "Elimde tavuk, pirinç ve soğan var"
🤖 Bot: "Aşağıda önerilen tarifler:"
      → Tavuklu Pilav
      → Tavuk Sote
      → Kremalı Tavuk

👤 User: "Sadece yumurta var"
🤖 Bot: "Aşağıda önerilen tarifler:"
      → Omlet
      → Sahanda Yumurta
      → Çırpılmış Yumurta
```

## 🏗️ Architecture

The app follows a clean, modular architecture:

```
lib/
├── data/              # Data models and ingredient mapping
├── models/            # Data models (Message, Recipe)
├── screens/           # UI screens (Chat, Recipe Detail, Splash)
├── services/          # API services (Recipe Service)
├── utils/             # Constants and utilities
└── widgets/           # Reusable UI components
```

### Key Components

- **RecipeService**: Handles Gemini AI integration and recipe generation
- **ChatScreen**: Main chat interface with real-time messaging
- **IngredientMap**: Comprehensive Turkish ingredient detection system
- **ChatBubble**: Custom chat UI component

## 🎨 Technologies Used

- **Flutter** - Cross-platform mobile framework
- **Dart** - Programming language
- **Google Gemini AI** - AI recipe generation
- **flutter_dotenv** - Environment variable management
- **Material Design** - UI/UX design system

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Google Gemini AI for powerful recipe generation
- Flutter team for the amazing framework
- Turkish cuisine for endless inspiration

## 📞 Contact

- GitHub: [@YOUR_USERNAME](https://github.com/YOUR_USERNAME)
- Project Link: [https://github.com/YOUR_USERNAME/ai-recipe-chatbot](https://github.com/YOUR_USERNAME/ai-recipe-chatbot)

---

**Made with ❤️ and AI**
