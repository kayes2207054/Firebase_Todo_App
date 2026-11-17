# Firebase Integrated Todo-List App

[![Flutter](https://img.shields.io/badge/Flutter-3.47.9-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13.7-blue.svg)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore-orange.svg)](https://firebase.google.com)
[![Platform](https://img.shields.io/badge/Platform-Android-green.svg)](https://www.android.com)
[![License](https://img.shields.io/badge/License-MIT-purple.svg)](LICENSE)

An enterprise-grade, modern Android Todo-List application engineered with Flutter, Firebase Authentication, and Cloud Firestore. Built for the **Autonomous Mobile Computing Lab Assignment**.

---

## 📋 Table of Contents
1. [Assignment Requirements & Fulfillment](#-assignment-requirements--fulfillment)
2. [Key Features](#-key-features)
3. [Architecture & Project Structure](#-architecture--project-structure)
4. [Firebase Integration & Security Rules](#-firebase-integration--security-rules)
5. [Getting Started & Setup Instructions](#-getting-started--setup-instructions)
6. [Testing & Verification](#-testing--verification)

---

## 🎯 Assignment Requirements & Fulfillment

| # | Requirement | Implementation Details | Status |
|---|---|---|:---:|
| 1 | **Task Title** | Validated single-line input stored in Firestore document | ✅ Completed |
| 2 | **Task Description** | Multi-line detailed notes/description field | ✅ Completed |
| 3 | **Complete CRUD Operations** | Full Create, Read, Update, and Delete operations with confirmation dialogs and reactive streams | ✅ Completed |
| 4 | **Firebase Authentication** | Email & Password registration, login, logout, session persistence, and error handling | ✅ Completed |
| 5 | **Cloud Firestore Database** | Real-time task collection storing `title`, `description`, `isCompleted`, `userId`, `createdAt`, `updatedAt` | ✅ Completed |
| 6 | **User-Specific Task Storage** | Tasks queried and filtered strictly by the authenticated user's `UID` | ✅ Completed |
| 7 | **Secure Firestore Rules** | Multi-tenant rules enforcing strict user isolation on read, create, update, and delete | ✅ Completed |
| 8 | **Modern UI/UX** | Material 3 design, dynamic statistics summary, loading states, empty states, and responsive dialogs | ✅ Completed |

---

## ✨ Key Features

- **Authentication Flow**:
  - Email & Password registration with format and match validation.
  - Secure sign-in with granular Firebase exception handling (wrong password, user not found, invalid email).
  - Stream-based authentication state management (`AuthWrapper`) preserving login sessions across app restarts.
  - User logout with confirmation dialog.

- **Task Management (CRUD)**:
  - **Create**: Floating Action Button triggers a validated task creation dialog.
  - **Read**: Live real-time stream via Cloud Firestore `snapshots()`, sorted by creation timestamp.
  - **Update**: Edit task title and description, or toggle task completion status directly from the card.
  - **Delete**: Remove tasks with an explicit confirmation dialog to prevent accidental data loss.

- **User-Specific Data Isolation**:
  - Each task document includes `userId: request.auth.uid`.
  - Queries filter with `.where('userId', isEqualTo: userId)`.
  - Firestore security rules reject any unauthorized read/write attempts.

- **Professional UI**:
  - Material 3 theme with dynamic color seeds.
  - Task counter metrics bar displaying Total, Pending, and Completed tasks.
  - Responsive empty state illustrations and animated loading indicators.

---

## 📂 Architecture & Project Structure

```text
e:\Firebase_Todo_App\
├── android\                    # Android native configuration (Gradle KTS, Manifest)
│   ├── app\
│   │   ├── build.gradle.kts   # Android build setup (minSdk 23, Google Services)
│   │   ├── google-services.json # Firebase Android configuration template
│   │   └── src\main\AndroidManifest.xml # Permissions (INTERNET, ACCESS_NETWORK_STATE)
│   ├── build.gradle.kts       # Top-level Gradle configuration
│   ├── gradle.properties      # JVM and Kotlin build properties
│   └── settings.gradle.kts    # Plugin repositories and Google Services plugin
├── lib\
│   ├── main.dart              # App entry point, Theme config, and AuthWrapper
│   ├── firebase_options.dart  # Cross-platform Firebase initialization options
│   ├── models\
│   │   └── todo_task.dart     # TodoTask data model with Firestore serialization
│   ├── services\
│   │   ├── auth_service.dart  # Firebase Authentication service & error handlers
│   │   └── firestore_service.dart # Cloud Firestore CRUD operations & streams
│   ├── screens\
│   │   ├── auth\
│   │   │   ├── login_screen.dart    # Login UI with email & password validation
│   │   │   └── register_screen.dart # User registration UI
│   │   └── dashboard\
│   │       ├── dashboard_screen.dart # Task list, summary metrics, and actions
│   │       └── task_dialog.dart     # Dialog for creating and editing tasks
│   └── widgets\
│       └── task_card.dart     # Interactive task item card with strike-through & actions
├── test\
│   └── widget_test.dart       # Unit and model verification tests
├── firestore.rules            # Firestore security rules enforcing user ownership
├── pubspec.yaml               # Dependencies (firebase_core, firebase_auth, cloud_firestore, intl)
└── README.md                  # Comprehensive project documentation
```

---

## 🔒 Firebase Integration & Live Cloud Backend

### Live Project Details
- **Firebase Project Name**: `Firebase-Todo-App`
- **Project ID**: `fir-todo-app-a9fbc`
- **Project Number**: `226859237139`
- **Registered Android App**: `com.todoapp.firebase_integrated_todo_app` (App ID: `1:226859237139:android:db72d08c3c8935947264e6`)
- **Authentication**: Email/Password Provider Enabled & Verified
- **Cloud Firestore**: Database `(default)` Provisioned & Deployed
- **Configuration**: Genuine `google-services.json` and `lib/firebase_options.dart` fully synchronized

### Firestore Security Rules (`firestore.rules`)
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /tasks/{taskId} {
      // Only authenticated users can read their own tasks
      allow read: if request.auth != null && resource.data.userId == request.auth.uid;

      // Only authenticated users can create tasks assigned to themselves
      allow create: if request.auth != null 
                    && request.resource.data.userId == request.auth.uid
                    && request.resource.data.title is string
                    && request.resource.data.description is string;

      // Only the owner can update their tasks; userId cannot be altered
      allow update: if request.auth != null 
                    && resource.data.userId == request.auth.uid
                    && request.resource.data.userId == request.auth.uid;

      // Only the owner can delete their tasks
      allow delete: if request.auth != null && resource.data.userId == request.auth.uid;
    }
  }
}
```

---

## 🚀 Getting Started & Setup Instructions

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.47+ recommended)
- [Android Studio](https://developer.android.com/studio) / Android SDK (API 34+)
- [Java JDK](https://adoptium.net/) (JDK 17 or higher)
- A Firebase project with **Authentication** (Email/Password) and **Cloud Firestore** enabled.

### 1. Clone the Repository
```bash
git clone https://github.com/kayes2207054/Firebase_Todo_App.git
cd Firebase_Todo_App
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Connect Your Firebase Project
1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Create a new Firebase project (or select an existing one).
3. Under **Build > Authentication**, enable **Email/Password**.
4. Under **Build > Firestore Database**, create a database and publish the rules from `firestore.rules`.
5. Add an Android app with package name `com.todoapp.firebase_integrated_todo_app`.
6. Download `google-services.json` and place it in `android/app/google-services.json`.
7. (Optional) Run `flutterfire configure` to generate `lib/firebase_options.dart`.

### 4. Run the Application
```bash
# Run on connected Android device or emulator
flutter run
```

### 5. Build Release APK
```bash
flutter build apk --release
```
The output APK will be located at:
`build/app/outputs/flutter-apk/app-release.apk`

---

## 🧪 Testing & Verification

Run static analysis and unit tests:
```bash
flutter analyze
flutter test
```

- **Static Analysis**: Verified with `flutter analyze` (0 errors, 0 warnings).
- **Unit Tests**: Verified with `flutter test` (`test/widget_test.dart` passes).

---

## 👤 Author
- **Student**: Kayes (`kayes2207054`)
- **Institution Email**: `kayes2207054@stud.kuet.ac.bd`
- **Repository**: [https://github.com/kayes2207054/Firebase_Todo_App](https://github.com/kayes2207054/Firebase_Todo_App)
