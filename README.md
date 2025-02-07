# 🎥 OGO - Movie Streaming App  

**OGO** is a modern and dynamic **movie streaming app** built with **Flutter**, offering an intuitive platform for discovering, streaming, and managing your favorite movies and TV shows.  

---
## 🚧 Project Status  

🚀 **Currently in Development:**  
This repository represents an ongoing project aimed at creating a unique streaming experience. Contributions and feedback are welcome!  

---

## ✨ Features (Planned & In-Progress)  

- **Browse Movies & TV Shows**: Access content from diverse genres and categories.  
- **Favorite & Watchlist**: Save your favorite titles and plan your next watch.  
- **Custom Lists**: Organize your movies into personalized collections.  
- **Multiple Streaming Qualities**: Adaptive streaming for various devices and internet speeds.  
- **Search Functionality**: Find content using keywords, genres, and more.  
- **Legal Content**: Aggregates content from public domain and licensed sources.
- WOrking on it -------------------------------------------------------------------------------------------- 

---

## 🛠️ Tech Stack  

- **Frontend**: Flutter (Dart)  
- **Backend**: Django REST Framework  
- **Authentication**: Firebase Authentication  
- **Streaming Engine**: FFmpeg for adaptive media processing  
- **APIs**: TMDb API for metadata and genre information  

---

## 🎨 UI/UX Highlights  

The app focuses on delivering a sleek and engaging user experience, with features like:  

- 🎬 Intuitive navigation for effortless browsing  
- 🌌 A clean, dark-themed interface for a cinematic feel  
- 🖼️ Dynamic visuals and animations for an immersive experience
- Many more 

---

## 🗂️ Project Structure  

```plaintext
We are following this type of structure 


lib/
│
├── main.dart                          # App entry point 
├── core/                              # Core logic and services used globally across the app
│   ├── constants/                     # Global constants (strings, assets paths, etc.)
│   │   └── app_constants.dart         # App-wide constants (e.g., route names, API keys)
│   │   └── assets.dart                # Asset paths like images and icons
│   │   └── colors.dart                # App color palette
│   │   └── typography.dart            # Text styles, font sizes, etc.
│   ├── utils/                         # Utility functions/helpers
│   │   └── date_time_helper.dart      # Date/time formatting functions
│   │   └── validator.dart             # Form input validators
│   │   └── api_response_parser.dart   # Helper for parsing API responses
│   ├── theme/                         # Theme-related configurations
│   │   └── app_theme.dart             # Main theme file (Light/Dark theme)
│   ├── services/                      # Global app services like API, notifications, etc.
│       └── api_service.dart           # Service handling API calls
│       └── local_storage_service.dart # Service handling local storage (e.g., SharedPreferences)
│       └── notification_service.dart  # Service handling notifications
│       └── auth_service.dart          # Authentication service for login/signup
│
├── features/                          # Grouping of app features by functionality
│   ├── authentication/                # Feature module for Authentication
│   │   ├── data/                      # Data-related classes (API, local storage)
│   │   │   └── auth_api.dart          # API calls for login/signup
│   │   ├── models/                    # Models related to authentication
│   │   │   └── user_model.dart        # User data model
│   │   ├── providers/                 # State management for authentication
│   │   │   └── auth_provider.dart     # Provider handling authentication state
│   │   ├── ui/                        # UI components related to authentication
│   │   │   └── login_screen.dart      # Login screen UI
│   │   │   └── signup_screen.dart     # Signup screen UI
│   │   ├── widgets/                   # Reusable widgets for authentication
│   │   │   └── login_form.dart        # Login form widget
│
│   ├── user_profile/                  # Feature module for user profile management
│   │   ├── data/                      # Data-related classes (API, local storage)
│   │   │   └── user_profile_api.dart  # API calls to fetch/update user profile
│   │   ├── models/                    # Models related to user profile
│   │   │   └── user_profile.dart      # User profile model
│   │   ├── providers/                 # State management for user profile
│   │   │   └── user_profile_provider.dart  # Provider handling profile state
│   │   ├── ui/                        # UI components related to user profile
│   │   │   └── profile_screen.dart    # User profile screen
│   │   ├── widgets/                   # Reusable widgets for user profile
│   │       └── profile_avatar.dart    # Widget for showing profile picture
│
│   ├── chat/                          # Feature module for chat functionality
│   │   ├── data/                      # Data-related classes (API, socket, database)
│   │   │   └── chat_api.dart          # API calls for chat messages
│   │   ├── models/                    # Models related to chat
│   │   │   └── chat_message.dart      # Chat message data model
│   │   ├── providers/                 # State management for chat
│   │   │   └── chat_provider.dart     # Provider handling chat state
│   │   ├── ui/                        # UI components for chat feature
│   │   │   └── chat_screen.dart       # Chat screen
│   │   ├── widgets/                   # Reusable widgets for chat
│   │       └── message_bubble.dart    # Message bubble widget
│
├── shared/                            # Shared UI components and reusable code
│   ├── widgets/                       # General reusable widgets used across multiple features
│   │   └── custom_button.dart         # Custom button widget used throughout the app
│   │   └── loading_spinner.dart       # Loading spinner widget
│   ├── modals/                        # Shared modals and dialogs
│   │   └── error_dialog.dart          # Error dialog modal
│
├── providers/                         # Global app-wide providers
│   └── theme_provider.dart            # Theme management for dark/light mode
│   └── language_provider.dart         # Localization or language change provider
│
├── routes/                            # Routing configuration
│   └── app_routes.dart                # Centralized route management
│
├── repositories/                      # Data repositories for complex data handling
│   └── user_repository.dart           # User repository for managing user-related data access
│   └── chat_repository.dart           # Chat repository for managing chat-related data
│
├── l10n/                              # Localization files
│   └── app_en.arb                     # Localization for English  
│   └── app_es.arb                     # Localization for Spanish
                      
```
##🌟 How to Run
- Clone this repository:
  git clone https://github.com/yourusername/ogo.git
  cd ogo
- Install dependencies:
  flutter pub get
- Run the app on your emulator or device:
  flutter run
## 📸 Screenshots
 .....
![Image](https://github.com/user-attachments/assets/567a0eba-3fdd-4667-96c5-6090728a69cf)

![Image](https://github.com/user-attachments/assets/a084fae5-d133-4af9-9b35-3fe9aae15f40)

![Image](https://github.com/user-attachments/assets/f8ae3d61-cb9c-4ee3-b801-49d1206fd9b9)

![Image](https://github.com/user-attachments/assets/c7beeea6-b403-4af2-841d-21cbcca4f9b7)

![Image](https://github.com/user-attachments/assets/45bb371d-c637-4f33-a692-d8b31da9b6a0)

![Image](https://github.com/user-attachments/assets/543c538b-5160-4414-a0f4-42b11cf47e6c)

![Image](https://github.com/user-attachments/assets/bb21b605-5689-40c1-b256-63f31ab3a739)

![Image](https://github.com/user-attachments/assets/345afc70-a47b-47f0-9d68-a9491b102262)

![Image](https://github.com/user-attachments/assets/cef6e7ca-516a-490f-9173-2f633d452d59)

![Image](https://github.com/user-attachments/assets/fb2ef844-208a-46d1-b950-dbdfa8b767c0)

![Image](https://github.com/user-attachments/assets/e2f498b4-8127-42f6-a2f6-066661bc3e7d)

![Image](https://github.com/user-attachments/assets/34b658c9-d3b3-412f-b098-5af4a3169c85)

![Image](https://github.com/user-attachments/assets/bf0f4005-e2b4-4e26-9729-848a44f62a62)

![Image](https://github.com/user-attachments/assets/64d94c06-758b-4e58-baa6-112b932106f6)

![Image](https://github.com/user-attachments/assets/82e1a1e8-e856-4c5d-bb33-47452f6d38c8) 

## 🌍 Contributing
- Contributions are welcome! If you have ideas for new features, bug fixes, or improvements, feel free to fork this repository and open a pull request.

📬 Contact
If you have any questions or feedback, feel free to reach out:
Email: gurpreetdhamu8586@gmail.com


REFERENCE UI -> 

https://www.behance.net/gallery/198896501/Movie-Streaming-App

Functionality Done by me for authentication i use Firebase but for Authorization i use DJANGO REST FRAMEWORK . Please connect if some issue Comes . 


