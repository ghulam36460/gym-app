# 🚀 Deployment Guide for Fitness Tracker App

This guide will help you deploy your Flutter Fitness Tracker app to GitHub Pages and Firebase Hosting.

## 📋 Prerequisites

### For GitHub Pages:
- GitHub account with Education Pack (free hosting)
- Git installed on your computer
- Repository pushed to GitHub

### For Firebase:
- Google account
- Firebase CLI installed
- Firebase project created

## 🔧 Setup Instructions

### 1. GitHub Pages Deployment

#### Step 1: Push to GitHub
```bash
# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit changes
git commit -m "Initial commit: Flutter Fitness Tracker App"

# Add remote origin (replace with your repository URL)
git remote add origin https://github.com/yourusername/fitness-tracker.git

# Push to GitHub
git push -u origin main
```

#### Step 2: Enable GitHub Pages
1. Go to your GitHub repository
2. Click on **Settings** tab
3. Scroll down to **Pages** section
4. Under **Source**, select **GitHub Actions**
5. The workflow will automatically deploy your app

#### Step 3: Access Your App
- Your app will be available at: `https://yourusername.github.io/fitness-tracker/`
- It may take a few minutes for the first deployment

### 2. Firebase Hosting Deployment

#### Step 1: Install Firebase CLI
```bash
# Install Firebase CLI globally
npm install -g firebase-tools

# Login to Firebase
firebase login
```

#### Step 2: Initialize Firebase Project
```bash
# Initialize Firebase in your project directory
firebase init hosting

# Select:
# - Use an existing project (or create new one)
# - Public directory: build/web
# - Configure as single-page app: Yes
# - Set up automatic builds with GitHub: Yes (optional)
```

#### Step 3: Build and Deploy
```bash
# Build the Flutter web app
flutter build web --release

# Deploy to Firebase
firebase deploy
```

#### Step 4: Access Your App
- Your app will be available at: `https://your-project-id.web.app/`
- Custom domain can be configured in Firebase Console

## 🤖 Automated Deployment (GitHub Actions)

The included GitHub Actions workflow (`.github/workflows/deploy.yml`) will automatically:

1. **Build** your Flutter app on every push to main/master
2. **Test** and analyze the code
3. **Deploy** to both GitHub Pages and Firebase

### Setup GitHub Secrets:
1. Go to repository **Settings** → **Secrets and variables** → **Actions**
2. Add these secrets:
   - `FIREBASE_TOKEN`: Get it by running `firebase login:ci`
   - `OPENAI_API_KEY`: Your OpenAI API key for the AI assistant feature

## 📱 Custom Domain Setup

### For GitHub Pages:
1. Add `CNAME` file to `web/` directory with your domain
2. Update DNS settings to point to GitHub Pages
3. Enable HTTPS in repository settings

### For Firebase:
1. Go to Firebase Console → Hosting
2. Click "Add custom domain"
3. Follow the verification steps
4. Update DNS records as instructed

## 🛠️ Build Commands

### Local Development:
```bash
# Run locally
flutter run -d chrome

# Build for web
flutter build web --release
```

### Production Build:
```bash
# Run the deployment script
./deploy.sh         # Linux/Mac
deploy.bat          # Windows
```

## 🔍 Troubleshooting

### Common Issues:

1. **Build fails**: Run `flutter clean && flutter pub get`
2. **GitHub Actions fails**: Check Flutter version in workflow file
3. **Firebase deployment fails**: Ensure Firebase CLI is logged in
4. **PWA not working**: Check manifest.json and service worker

### Performance Optimization:

1. **Enable web compression** in hosting settings
2. **Use CDN** for better global performance
3. **Optimize images** in assets folder
4. **Enable caching** headers (already configured)

## 📊 Monitoring

### GitHub Pages:
- Monitor deployments in **Actions** tab
- View traffic in **Insights** → **Traffic**

### Firebase:
- Monitor usage in Firebase Console
- Set up performance monitoring
- Configure analytics

## 🎯 Next Steps

1. **Set up custom domain** for professional URL
2. **Enable PWA features** for mobile experience
3. **Add analytics** to track user engagement
4. **Set up monitoring** for performance tracking
5. **Configure CI/CD** for automated testing

## 📞 Support

If you encounter issues:
1. Check the GitHub Actions logs
2. Review Firebase Console for errors
3. Test locally with `flutter run -d chrome`
4. Ensure all dependencies are up to date

---

**Happy Deploying! 🚀💪**
