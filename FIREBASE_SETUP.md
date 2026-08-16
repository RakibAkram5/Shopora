// Firebase Configuration & Initialization Guide for Shopora

To connect your own Firebase project to **Shopora**, follow these simple steps:

1. **Install Firebase CLI**:
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase**:
   ```bash
   firebase login
   ```

3. **Install FlutterFire CLI**:
   ```bash
   dart pub global activate flutterfire_cli
   ```

4. **Configure Firebase for your Flutter App**:
   Run the following command in the root of your project:
   ```bash
   flutterfire configure
   ```
   This will automatically generate `lib/firebase_options.dart` containing your project credentials for Android, iOS, Web, and macOS.

5. **Update `lib/main.dart`**:
   Import `firebase_options.dart` and pass it to `Firebase.initializeApp`:
   ```dart
   import 'firebase_options.dart';
   
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
   ```

6. **Deploy Security Rules**:
   Deploy your Firestore and Storage security rules to your Firebase console:
   ```bash
   firebase deploy --only firestore:rules,storage
   ```
