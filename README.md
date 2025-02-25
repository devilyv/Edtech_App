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

Planning and Technology Stack
Before starting development, I planned the structure of the application by identifying user roles and their functionalities:

Students: Apply for scholarships and track application status.
Agents: Manage students’ applications and update statuses.
Admin: Manage users, applications, and settings.
The app was built using:

Flutter (for cross-platform development)
Firebase Authentication (for secure login and role management)
Firebase Firestore (for storing application and user data)
GitHub (for version control and collaboration)
Development Process
1. Project Setup
I set up the Flutter project in VS Code and integrated Firebase by adding the necessary configurations to google-services.json (for Android) and Info.plist (for iOS). The database structure was designed in Firestore, creating collections like users and applications.

2. Role-Based Authentication
Using Firebase Authentication, I implemented email/password login and assigned user roles. The logic ensures that after login, users are redirected based on their roles:

Students → Home Page for Students
Agents → Application Management Page
Admins → User Management Page
3. Application Tracking System
This feature allows students to track their scholarship applications and agents to manage them. A StreamBuilder was used to fetch live data updates from Firestore. Agents can update the status of applications, and students can view changes in real-time.

4. Scholarship Finder
I implemented a Firestore query to fetch scholarships based on user preferences. The UI includes a search feature that lets students filter scholarships by category.

5. AI Profile Matcher (Upcoming Feature)
This feature is designed to match students with the best possible scholarships using an AI model trained on historical data. It will be integrated in future updates using TensorFlow Lite.

Challenges Faced
1. Firebase Integration Issues
Initially, authentication and Firestore queries had issues due to incorrect Firebase configurations. I resolved them by carefully setting up google-services.json and adding the required dependencies.

2. Role-Based Navigation
Redirecting users based on roles was complex. I handled it using StreamBuilder and Firebase's onAuthStateChanged listener to dynamically route users.

3. Performance Optimization
Firestore queries were slowing down the app. I improved performance by:

Using indexed queries to fetch specific user data
Implementing pagination for long lists
Caching data to reduce redundant reads
Future Improvements
AI Profile Matching System (to enhance recommendations)
Push Notifications (to alert users about updates)
Better UI/UX Enhancements
Conclusion
Developing edtech_app was an enriching experience, strengthening my skills in Flutter and Firebase. Despite challenges, I successfully implemented role-based authentication, application tracking, and scholarship search. I plan to continue refining the app with AI-powered features and better user engagement tools.

