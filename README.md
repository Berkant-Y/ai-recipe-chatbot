# 🤖 AI Recipe Chatbot | AI Tarif Chatbotu

[🇺🇸 English](#english) | [🇹🇷 Türkçe](#türkçe)

---

## 🇺🇸 English

AI-powered Flutter chatbot that suggests recipes based on available ingredients. Built with Gemini AI.

### 📱 Features

- **Smart Ingredient Detection**: Automatically detects Turkish ingredients from your messages
- **AI-Powered Suggestions**: Uses Google Gemini AI to generate personalized recipe recommendations
- **Interactive Chat Interface**: Clean and intuitive chat UI for seamless user experience
- **Recipe Details**: Detailed cooking instructions, ingredients list, and cooking time
- **Turkish Language Support**: Fully localized for Turkish cuisine and ingredients
- **Cross-Platform**: Runs on Android, iOS, and Web

### 🚀 Getting Started

#### Prerequisites

- Flutter SDK (>=3.8.0)
- Dart SDK
- Android Studio / VS Code
- Google Gemini API Key

#### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Berkant-Y/ai-recipe-chatbot.git
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

### 🔧 Configuration

#### Getting Gemini API Key

1. Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Create a new API key
3. Add it to your `.env` file

#### Supported Platforms

- ✅ Android
- ✅ iOS  
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

### 📖 Usage

1. **Start the app** and you'll see a welcome message
2. **Type your available ingredients** in Turkish (e.g., "Elimde soğan, domates ve patates var")
3. **Get AI suggestions** - The bot will suggest recipes you can make
4. **Tap on recipes** to see detailed cooking instructions
5. **Enjoy cooking!** 🍳

#### Example Conversations

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

### 🏗️ Architecture

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

#### Key Components

- **RecipeService**: Handles Gemini AI integration and recipe generation
- **ChatScreen**: Main chat interface with real-time messaging
- **IngredientMap**: Comprehensive Turkish ingredient detection system
- **ChatBubble**: Custom chat UI component

### 🎨 Technologies Used

- **Flutter** - Cross-platform mobile framework
- **Dart** - Programming language
- **Google Gemini AI** - AI recipe generation
- **flutter_dotenv** - Environment variable management
- **Material Design** - UI/UX design system

### 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 🇹🇷 Türkçe

Elinizde bulunan malzemelere göre yemek tarifleri öneren, Gemini AI ile güçlendirilmiş Flutter chatbot uygulaması.

### 📱 Özellikler

- **Akıllı Malzeme Tespiti**: Mesajlarınızdan Türkçe malzemeleri otomatik olarak algılar
- **AI Destekli Öneriler**: Google Gemini AI kullanarak kişiselleştirilmiş tarif önerileri üretir
- **Etkileşimli Chat Arayüzü**: Temiz ve sezgisel sohbet UI'ı
- **Tarif Detayları**: Detaylı pişirme talimatları, malzeme listesi ve pişirme süresi
- **Türkçe Dil Desteği**: Türk mutfağı ve malzemeleri için tamamen yerelleştirilmiş
- **Çoklu Platform**: Android, iOS ve Web üzerinde çalışır

### 🚀 Başlangıç

#### Gereksinimler

- Flutter SDK (>=3.8.0)
- Dart SDK
- Android Studio / VS Code
- Google Gemini API Anahtarı

#### Kurulum

1. **Depoyu klonlayın**
   ```bash
   git clone https://github.com/Berkant-Y/ai-recipe-chatbot.git
   cd ai-recipe-chatbot
   ```

2. **Bağımlılıkları yükleyin**
   ```bash
   flutter pub get
   ```

3. **Ortam değişkenlerini ayarlayın**
   
   Kök dizinde `.env` dosyası oluşturun:
   ```env
   GEMINI_API_KEY=gemini_api_anahtariniz_buraya
   ```

4. **Uygulamayı çalıştırın**
   ```bash
   flutter run
   ```

### 🔧 Yapılandırma

#### Gemini API Anahtarı Alma

1. [Google AI Studio](https://makersuite.google.com/app/apikey)'yu ziyaret edin
2. Yeni bir API anahtarı oluşturun
3. `.env` dosyanıza ekleyin

#### Desteklenen Platformlar

- ✅ Android
- ✅ iOS  
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

### 📖 Kullanım

1. **Uygulamayı başlatın** ve karşılama mesajını görün
2. **Mevcut malzemelerinizi yazın** (örn: "Elimde soğan, domates ve patates var")
3. **AI önerilerini alın** - Bot yapabileceğiniz tarifleri önerecek
4. **Tariflere dokunun** ve detaylı pişirme talimatlarını görün
5. **Keyifle pişirin!** 🍳

#### Örnek Konuşmalar

```
� Kullanıcı: "Elimde tavuk, pirinç ve soğan var"
🤖 Bot: "Aşağıda önerilen tarifler:"
      → Tavuklu Pilav
      → Tavuk Sote
      → Kremalı Tavuk

👤 Kullanıcı: "Sadece yumurta var"
🤖 Bot: "Aşağıda önerilen tarifler:"
      → Omlet
      → Sahanda Yumurta
      → Çırpılmış Yumurta
```

### 🏗️ Mimari

Uygulama temiz ve modüler bir mimari takip eder:

```
lib/
├── data/              # Veri modelleri ve malzeme haritası
├── models/            # Veri modelleri (Message, Recipe)
├── screens/           # UI ekranları (Chat, Recipe Detail, Splash)
├── services/          # API servisleri (Recipe Service)
├── utils/             # Sabitler ve yardımcı araçlar
└── widgets/           # Yeniden kullanılabilir UI bileşenleri
```

#### Ana Bileşenler

- **RecipeService**: Gemini AI entegrasyonu ve tarif üretimini yönetir
- **ChatScreen**: Gerçek zamanlı mesajlaşma ile ana sohbet arayüzü
- **IngredientMap**: Kapsamlı Türkçe malzeme tespit sistemi
- **ChatBubble**: Özel sohbet UI bileşeni

### 🎨 Kullanılan Teknolojiler

- **Flutter** - Çoklu platform mobil framework
- **Dart** - Programlama dili
- **Google Gemini AI** - AI tarif üretimi
- **flutter_dotenv** - Ortam değişkeni yönetimi
- **Material Design** - UI/UX tasarım sistemi

### 🤝 Katkıda Bulunma

Katkılar memnuniyetle karşılanır! Lütfen bir Pull Request göndermekten çekinmeyin.

1. Projeyi fork edin
2. Özellik dalınızı oluşturun (`git checkout -b feature/HarikaBirOzellik`)
3. Değişikliklerinizi commit edin (`git commit -m 'Harika bir özellik ekle'`)
4. Dalınıza push yapın (`git push origin feature/HarikaBirOzellik`)
5. Bir Pull Request açın

### 📝 Lisans

Bu proje MIT Lisansı altında lisanslanmıştır - detaylar için [LICENSE](LICENSE) dosyasına bakın.

### � Teşekkürler

- Güçlü tarif üretimi için Google Gemini AI'ya
- Muhteşem framework için Flutter ekibine
- Sonsuz ilham için Türk mutfağına

### 📞 İletişim

- GitHub: [@Berkant-Y](https://github.com/Berkant-Y)
- Proje Linki: [https://github.com/Berkant-Y/ai-recipe-chatbot](https://github.com/Berkant-Y/ai-recipe-chatbot)

---

**❤️ ve AI ile yapıldı**
