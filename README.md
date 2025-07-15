# Fitness Tracker App

A comprehensive fitness tracking application built with Flutter and Dart. Track your workouts, monitor progress, and achieve your fitness goals with this modern, user-friendly app.

## Features

### 🏋️ Workout Management
- Create custom workouts with exercise selections
- Pre-loaded exercise library with detailed instructions
- Track sets, reps, weights, and duration
- Start and complete workout sessions
- Add notes to workouts

### 📊 Progress Tracking
- Visual progress charts and analytics
- Weekly and monthly workout statistics
- Body metrics tracking (weight, height, BMI)
- Achievement system

### 👤 User Profile
- Personalized user profiles
- Fitness goal setting
- Profile picture management
- BMI calculation and health metrics

### 🤖 AI Personal Assistant
- **Real-time OpenAI integration** with GPT-3.5-turbo
- **Personalized fitness coaching** based on your workout data
- **Smart workout analysis** and progress insights
- **Nutrition and motivation guidance** tailored to your goals
- **Quick action buttons** for instant fitness tips
- **Conversation history** for context-aware responses

### 🎨 Modern UI/UX
- Beautiful Material Design interface
- Smooth animations with animate_do
- Responsive design for all screen sizes
- Dark/Light theme support
- Interactive charts with fl_chart

## Technology Stack

- **Framework**: Flutter 3.10+
- **Language**: Dart 3.0+
- **State Management**: Provider
- **Local Storage**: SharedPreferences
- **Charts**: fl_chart
- **Animations**: animate_do
- **Fonts**: Google Fonts (Roboto)
- **AI Integration**: OpenAI GPT-3.5-turbo
- **HTTP Client**: http package

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  provider: ^6.1.1
  shared_preferences: ^2.2.2
  intl: ^0.19.0
  sqflite: ^2.3.0
  path: ^1.8.3
  image_picker: ^1.0.4
  charts_flutter_new: ^0.12.0
  fl_chart: ^0.65.0
  animate_do: ^3.1.2
  google_fonts: ^6.1.0
```

## Getting Started

### Prerequisites
- Flutter SDK (3.10.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code
- Android device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/fitness_tracker.git
   cd fitness_tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### 🚀 Deployment

This app is configured for deployment on:

**GitHub Pages (Free with Education Pack):**
```bash
# Push to GitHub and enable Pages in repository settings
git push origin main
```

**Firebase Hosting:**
```bash
# Build and deploy
flutter build web --release
firebase deploy
```

**Quick Deploy:**
```bash
# Use the included deployment script
./deploy.sh         # Linux/Mac
deploy.bat          # Windows
```

For detailed deployment instructions, see [DEPLOYMENT.md](DEPLOYMENT.md).

### 🌐 Live Demo

- **GitHub Pages**: `https://yourusername.github.io/fitness-tracker/`
- **Firebase**: `https://your-project-id.web.app/`

### Building for Release

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── user.dart
│   └── workout.dart
├── providers/                # State management
│   ├── user_provider.dart
│   └── workout_provider.dart
├── screens/                  # UI screens
│   ├── home_screen.dart
│   ├── workout_screen.dart
│   ├── progress_screen.dart
│   └── profile_screen.dart
├── widgets/                  # Reusable widgets
│   ├── workout_card.dart
│   ├── stats_card.dart
│   ├── quick_actions.dart
│   ├── exercise_card.dart
│   ├── create_workout_dialog.dart
│   └── profile_setup_dialog.dart
└── services/                 # Business logic
    └── storage_service.dart
```

## Key Features Detailed

### Workout Creation
- Select from pre-loaded exercise library
- Add custom exercises
- Set workout goals and notes
- Organize by muscle groups

### Exercise Library
Includes exercises for:
- Chest (Push-ups, Bench Press)
- Back (Pull-ups, Deadlifts)
- Legs (Squats, Lunges)
- Shoulders (Overhead Press)
- Arms (Bicep Curls, Tricep Dips)
- Core (Planks, Crunches)

### Progress Analytics
- Weekly workout frequency charts
- Monthly progress overview
- BMI tracking and health metrics
- Achievement badges

### User Profile Management
- Personal information setup
- Fitness goal selection
- Body metrics tracking
- Profile customization

## Screenshots

*Note: Add screenshots of your app here once built*

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Future Enhancements

- [ ] Workout templates and sharing
- [ ] Social features and challenges
- [ ] Nutrition tracking
- [ ] Wearable device integration
- [ ] Cloud sync and backup
- [ ] Personal trainer mode
- [ ] Video exercise demonstrations

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, email support@fitnesstracker.com or create an issue in this repository.

## Acknowledgments

- Flutter team for the amazing framework
- Material Design for UI inspiration
- Contributors and testers

---

**Start your fitness journey today! 💪**
