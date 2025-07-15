@echo off
echo 🏋️ Building Fitness Tracker for Web...

REM Clean previous builds
echo 🧹 Cleaning previous builds...
flutter clean

REM Get dependencies
echo 📦 Getting dependencies...
flutter pub get

REM Analyze code
echo 🔍 Analyzing code...
flutter analyze

REM Build for web
echo 🌐 Building for web...
flutter build web --release --web-renderer html --base-href /fitness-tracker/

echo ✅ Build completed! Files are in build/web/
echo.
echo 🚀 Deployment options:
echo 1. Firebase: Run 'firebase deploy'
echo 2. GitHub Pages: Push to GitHub and enable Pages in repository settings
echo 3. Manual: Upload build/web/ contents to your web server
echo.
echo 📱 Your app is ready for deployment!
pause
