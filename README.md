# HealthyEats 🥗

A personalized nutrition app built with Flutter that provides AI-powered dietary recommendations based on specific health conditions.

## 🌟 About The Project

HealthyEats is designed to help users manage their diet based on their personal health profile. By offering tailored nutritional advice and leveraging AI, the app ensures that users can easily discover meals that suit their specific health needs.

### Key Features
- **AI-Powered Recommendations:** Get smart dietary advice tailored to your specific health conditions.
- **Food Scanner:** Quickly scan food items or upload images using the device camera to analyze nutritional content.
- **Progress Tracking:** Monitor your diet and health metrics with interactive charts and visual indicators.
- **Modern UI:** A beautiful, responsive design with smooth animations and intuitive navigation.

## 🛠 Tech Stack & Libraries

- **Framework:** Flutter (Dart)
- **State Management:** Provider
- **Routing:** Go Router
- **UI & Animations:** Animate Do, Staggered Animations, Shimmer, Google Fonts, Font Awesome
- **Charts:** FL Chart, Percent Indicator
- **Hardware Integration:** Camera, Image Picker

## 📥 Download & Test the App

Since the `build/` directory is automatically generated and intentionally excluded from version control, you won't find the `.apk` files directly in the source code after cloning. 

To test the app, you have two options:

**Option 1: Download from Releases (Recommended for Testers)**
If the developer has provided pre-compiled APKs, you can download them directly from the **[Releases](../../releases)** page of this repository.

**Option 2: Build it yourself (For Developers)**
If you have Flutter installed, you can generate the APK yourself:
1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Run the following command to generate a release APK:
   ```bash
   flutter build apk --release
   ```
4. The generated APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`

### How to Install the APK:
1. Transfer the `.apk` file to your Android device.
2. Tap the file to open it.
3. If prompted, allow your device to "Install unknown apps" from the source.
4. Follow the on-screen instructions to install and open the app.

## 🚀 Getting Started for Developers

To run this project locally, make sure you have [Flutter](https://docs.flutter.dev/get-started/install) installed.

1. Clone the repository.
2. Run `flutter pub get` to install all dependencies.
3. Run `flutter run` to launch the app on your connected device or emulator.
