# News Client

A simple Flutter news app using MVVM architecture to browse and read news articles.

## Features

- **Browse News Articles:** Explore a wide range of news articles fetched from the NewsAPI.
- **Read Articles:** Enjoy a clean and readable interface for viewing full article content.
- **Save Favorites:**  Mark articles as favorites and store them locally using SQLite for offline access.
- **Unit Tests:** Includes unit tests for critical components to ensure code reliability.

## Setup

To run this app on an Android or iOS emulator, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/amalikrigger/news_client.git
    cd news_client
    ```
    This command will clone the project repository to your local machine and navigate you into the project directory.

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
    This command downloads all the necessary packages and libraries defined in the `pubspec.yaml` file. Ensure you have Flutter installed and configured correctly on your system before running this command.

3.  **Add your NewsAPI key:**
    - Open the file `lib/shared.dart`.
    - Locate the line that looks like: `const apiKey = 'YOUR_API_KEY';`
    - Replace `YOUR_API_KEY` with your actual API key from [NewsAPI](https://newsapi.org/).  **You need to sign up for a free account at NewsAPI to get your API key.**

4.  **URL Launcher Configuration:**
    For projects utilizing URL launching functionality, like this News Client, you will need to perform platform-specific configurations. **For more detailed information, refer to the [url_launcher package documentation](https://pub.dev/packages/url_launcher).**

    To use the URL launcher functionality (e.g., to open article links in a browser), you need to configure your project for each platform:

    **iOS:**
    - Open `ios/Runner/Info.plist`.
    - Add the following entries within the `<dict>` section:

    ```xml
    <key>LSApplicationQueriesSchemes</key>
    <array>
      <string>http</string>
      <string>https</string>
      <!-- Add other schemes you might need, like 'tel', 'sms', etc., if applicable -->
    </array>
    ```
    This configuration is necessary for `url_launcher` to correctly check if an app can handle a specific URL scheme.  For web links (http/https), it's generally recommended to include these.

    **Android:**
    - Open `android/app/src/main/AndroidManifest.xml`.
    - Add the following `<queries>` element as a child of the root `<manifest>` element:

    ```xml
    <manifest ...>
        <queries>
          <!-- For web links -->
          <intent>
            <action android:name="android.intent.action.VIEW" />
            <data android:scheme="http"/>
          </intent>
          <intent>
            <action android:name="android.intent.action.VIEW" />
            <data android:scheme="https"/>
          </intent>
          <!-- Add other schemes you might need, like 'tel', 'sms', etc., if applicable -->
        </queries>
        <application ...>
            ...
        </application>
    </manifest>
    ```
    Starting from Android 11 (API level 30), you need to declare URL schemes your app intends to query using the `<queries>` element in your `AndroidManifest.xml`. This ensures your app can correctly launch external URLs.

5.  **Run the app on an emulator:**
    - Make sure you have an Android emulator or iOS simulator running on your computer. If you don't have one set up, follow the Flutter documentation for setting up emulators/simulators for your operating system.
    - Execute the following command in your terminal:
        ```bash
        flutter run
        ```
    - Flutter will automatically detect the running emulator/simulator, build the app, and launch it on the device.
   
---

## Project Structure

The project follows the Model-View-ViewModel (MVVM) architecture to ensure a clean separation of concerns:

-   **`lib/articles/models`:** Contains data models representing news articles and other data structures.
-   **`lib/articles/view_models`:** Houses ViewModels that manage the state and logic for the UI. ViewModels act as intermediaries between the Models and Views.
-   **`lib/articles/views`:**  Implements the user interface using Flutter widgets. Views observe ViewModels and display data to the user.
-   **`lib/articles/services`:** Contains services for data fetching (e.g., `api_service.dart` for NewsAPI calls) and potentially other external services.
-   **`lib/articles/repositories`:** Contains repositories responsible for data access and management related to articles, including fetching from API and local storage (SQLite).
-   **`test`:**  Directory for unit tests, ensuring the reliability of critical components.
-   **`lib/main.dart`:** The entry point of the Flutter application.

## API Key

**Important:** You **must** obtain your own API key from [NewsAPI](https://newsapi.org/) and insert it into `lib/shared.dart` as described in the Setup instructions. The app will not function correctly without a valid API key.

## Running Tests

To run the unit tests for the project, use the following command in your terminal:

```bash
flutter test
```

---

## Configuration

### Refresh Interval

The article refresh interval is 30 seconds by default.

**To change it:**

1. **Open:**  `lib/features/articles/services/articles_refresh_service.dart`
   (or the file where you define `ArticlesRefreshService`).

2. **Locate:** The `ArticlesRefreshService` constructor.

3. **Find & Modify:** The `refreshInterval` parameter when you create an instance of `ArticlesRefreshService`. For example:

   ```dart
   final articlesRefreshService = ArticlesRefreshService(
     [],
     newsService: myNewsServiceInstance,
     sourceId: 'your-source-id',
     refreshInterval: const Duration(minutes: 1), // <-- Change this Duration
   );