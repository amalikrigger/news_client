# News Client

A simple Flutter news app using MVVM architecture.

## Features

- Browse and read articles from NewsAPI.
- Save (favorite) articles locally using SQLite.
- Auto-refresh using background tasks (via Workmanager).
- Unit tests for critical components.

## Setup

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Insert your NewsAPI key in `lib/services/api_service.dart` (replace `YOUR_API_KEY`).
4. Run the app on an emulator:
   ```bash
   flutter run
5. Test the app:
   ```bash
   flutter run


---

## Final Thoughts

- **MVVM Separation:**  
  The Model (data), ViewModel (state and logic), and View (UI) are clearly separated.

- **Performance & Efficiency:**  
  Use ListView.builder for efficient list rendering and consider lazy-loading or pagination if your API supports it. Handle exceptions gracefully.

- **Best Practices:**
    - Dependency injection (using Provider) for easier testing and separation.
    - Meaningful error messages and user feedback.
    - Write modular and testable code.

Following this guide will help you build a clean, maintainable, and high-quality Flutter news app that meets the assessment requirements. Good luck with your interview at HeadSpace!
