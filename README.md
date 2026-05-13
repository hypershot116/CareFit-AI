<div align="center">

<img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
<img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
<img src="https://img.shields.io/badge/Groq-F55036?style=for-the-badge&logo=groq&logoColor=white" />
<img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" />

# 🏋️ CareFit AI

### Your Personal AI Fitness Coach

*A gorgeous Android app that generates fully personalized fitness plans powered by Groq AI — tailored to your goals, lifestyle, and fitness level.*

<br/>

[![Download APK](https://img.shields.io/badge/⬇️%20Download%20APK-v1.0.0-6C63FF?style=for-the-badge)](https://drive.google.com/drive/folders/1s_gJJzEsKYfPUaUwnshV-hDFVJ1nagJZ?usp=sharing)

</div>

---

## 📱 Screenshots

> *Onboarding → Home → Fitness Form → AI Generated Plan*

---

## ✨ Features

- 🔑 **BYOK (Bring Your Own Key)** — Uses your own free Groq API key, verified instantly on entry
- 🤖 **AI-Powered Plans** — Generates detailed, personalized fitness routines using `llama-3.3-70b-versatile`
- 📋 **5-Step Smart Form** — Collects your age, goals, experience, health, diet, and preferences
- 📄 **PDF Export** — Download your full fitness plan as a formatted, mobile-readable PDF
- 🔒 **Secure Storage** — API key stored locally using encrypted shared preferences, never leaves your device
- 🎨 **Gorgeous Dark UI** — Material 3 design with purple/teal gradient theme
- ⚙️ **Settings Screen** — View, update, or delete your API key anytime

---

## 🚀 Getting Started

### Prerequisites

- Android device (Android 6.0 or higher)
- A free [Groq API key](https://console.groq.com)

### Installation

1. Download the latest APK from the link below
2. On your Android phone, go to **Settings → Install unknown apps** and allow installation
3. Open the downloaded APK and tap **Install**
4. Launch **CareFit AI**
5. Enter your free Groq API key to get started

> 📥 **[Download CareFit AI v1.0.0 APK](https://drive.google.com/drive/folders/1s_gJJzEsKYfPUaUwnshV-hDFVJ1nagJZ?usp=sharing)**

---

## 🔑 How to Get a Free Groq API Key

1. Go to **[console.groq.com](https://console.groq.com)**
2. Sign up with Google or Email (free)
3. Click **API Keys** → **Create API Key**
4. Copy the key (starts with `gsk_...`)
5. Paste it into CareFit AI on first launch

> The free tier is generous and more than enough for personal use.

---

## 🧠 How It Works

```
User fills 5-step form
        ↓
App builds a detailed prompt using your profile
        ↓
Prompt is sent to Groq API (llama-3.3-70b-versatile)
        ↓
AI generates a full personalized fitness plan
        ↓
Plan is displayed with markdown formatting
        ↓
User can save it as PDF or regenerate
```

---

## 📋 What the Form Covers

| Step | Fields |
|------|--------|
| 👤 **Basic Info** | Age, gender, height, weight, body type |
| 🎯 **Goals** | Primary goal, secondary goals, timeline, experience level |
| 🏋️ **Training Setup** | Days/week, session duration, equipment, training style |
| 🏥 **Health & Lifestyle** | Occupation, sleep, stress, injuries, health conditions, medications |
| 🥗 **Diet & Preferences** | Diet type, nutrition guidance, warm-up preference, favorite/avoided exercises |

---

## 📄 What the AI Plan Includes

1. **Personal Profile Analysis** — Summary and key considerations
2. **Training Strategy Overview** — Recommended split and weekly schedule
3. **Detailed Workout Plan** — Exercises, sets, reps, rest, form cues per day
4. **Progressive Overload & Recovery** — Week-by-week progression and deload strategy
5. **Cardio Recommendations** — Type, frequency, duration, intensity
6. **Nutrition Guidance** *(optional)* — Calories, macros, meal timing, supplements
7. **Lifestyle Optimization Tips** — Sleep, stress management, consistency
8. **Safety Notes & Disclaimer**

---

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| **Flutter 3.41.9** | UI framework & APK build |
| **Dart** | Programming language |
| **Groq API** | AI inference (llama-3.3-70b-versatile) |
| **flutter_secure_storage** | Encrypted API key storage |
| **flutter_markdown** | Render AI response beautifully |
| **pdf + printing** | Generate & export PDF plans |
| **google_fonts** | Poppins typography |
| **http** | API communication |
| **url_launcher** | Open external links |

---

## 🏗️ Project Structure

```
lib/
├── main.dart                  # App entry point
├── theme/
│   └── app_theme.dart         # Colors, typography, component themes
├── models/
│   └── user_profile.dart      # User data model
├── services/
│   ├── groq_service.dart      # Groq API calls & prompt building
│   └── storage_service.dart   # Secure key storage
└── screens/
    ├── onboarding_screen.dart  # API key input & verification
    ├── home_screen.dart        # Main dashboard
    ├── form_screen.dart        # 5-step fitness profile form
    ├── result_screen.dart      # AI plan display + PDF export
    └── settings_screen.dart    # Key management
```

---

## 🔧 Build From Source

```bash
# Clone the repository
git clone https://github.com/hypershot116/CareFit-AI.git
cd CareFit-AI

# Install dependencies
flutter pub get

# Run in debug mode
flutter run -d chrome

# Build release APK
flutter build apk --release
```

> APK will be at `build/app/outputs/flutter-apk/app-release.apk`

---

## ⚠️ Disclaimer

CareFit AI provides AI-generated fitness guidance for informational purposes only. It is **not a substitute** for professional medical advice, physical therapy, or in-person coaching. Always consult a doctor before starting any new exercise program, especially if you have existing health conditions, injuries, or chronic pain.

---

## 👤 Developer

**Shaikh Faiyaz Shahriyer**
B.Sc. Computer Science — BRAC University

[![GitHub](https://img.shields.io/badge/GitHub-hypershot116-181717?style=flat&logo=github)](https://github.com/hypershot116)

---

<div align="center">

Made with ❤️ using Flutter & Groq AI

⭐ Star this repo if you found it helpful!

</div>
