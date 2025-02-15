# Edtech App

## Project Overview
Edtech App is a cross-platform mobile application that helps students find scholarships, track applications, and connect with agents for guidance. The app provides role-based authentication and an intuitive user interface for managing educational opportunities efficiently.

## Features
- **Role-Based Authentication**: Supports Student, Agent, and Admin roles.
- **Scholarship Finder**: Browse and apply for available scholarships.
- **Application Tracking**: Monitor the status of student applications in real-time.
- **User Management**: Admins can manage users and their roles within the system.
- **Secure Authentication**: Firebase Authentication ensures user data security.
- **Firestore Database**: Stores user information, applications, and interactions seamlessly.

## Installation Steps
1. **Clone the repository**
   ```sh
   git clone https://github.com/devilyv/Edtech_App.git
   cd Edtech_App
   ```
2. **Install Flutter dependencies**
   ```sh
   flutter pub get
   ```
3. **Set up Firebase**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
   - Enable Firestore Database and Firebase Authentication.
   - Download `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) and place them in the appropriate directories.

4. **Run the app**
   ```sh
   flutter run
   ```

## Tech Stack
- **Frontend**: Flutter (Dart)
- **Backend**: Firebase Firestore (NoSQL Database)
- **Authentication**: Firebase Authentication
- **State Management**: Provider (if used)
- **Hosting**: GitHub (for code), Firebase (for backend services)

## Screenshots
![](C:\Users\sv656\Music\Demongel\edtech_app\assets\Screenshot 2025-02-15 165428.png)
![](C:\Users\sv656\Music\Demongel\edtech_app\assets\Screenshot 2025-02-15 165449.png)
![](C:\Users\sv656\Music\Demongel\edtech_app\assets\Screenshot 2025-02-15 165511.png)


## Contributing
We welcome contributions! Feel free to open issues or submit pull requests.

## License
This project is open-source and available for public use.

## Contact
For any questions or feedback, reach out via GitHub Issues or email.

---
**Push the README to your repository:**
```sh
git add README.md
git commit -m "Added README file"
git push origin main
```

