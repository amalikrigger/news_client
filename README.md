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
    - Open the file `lib/services/api_service.dart`.
    - Locate the line that looks like: `const apiKey = 'YOUR_API_KEY';`
    - Replace `YOUR_API_KEY` with your actual API key from [NewsAPI](https://newsapi.org/).  **You need to sign up for a free account at NewsAPI to get your API key.**

4.  **Run the app on an emulator:**
    - Make sure you have an Android emulator or iOS simulator running on your computer. If you don't have one set up, follow the Flutter documentation for setting up emulators/simulators for your operating system.
    - Execute the following command in your terminal:
        ```bash
        flutter run
        ```
    - Flutter will automatically detect the running emulator/simulator, build the app, and launch it on the device.

---

## Project Structure

The project follows the Model-View-ViewModel (MVVM) architecture to ensure a clean separation of concerns:

-   **`lib/models`:** Contains data models representing news articles and other data structures.
-   **`lib/view_models`:** Houses ViewModels that manage the state and logic for the UI. ViewModels act as intermediaries between the Models and Views.
-   **`lib/views`:**  Implements the user interface using Flutter widgets. Views observe ViewModels and display data to the user.
-   **`lib/services`:** Contains services for data fetching (e.g., `api_service.dart` for NewsAPI calls) and local data persistence (e.g., using SQLite).
-   **`lib/database`:**  Files related to local database setup and interactions using SQLite.
-   **`test`:**  Directory for unit tests, ensuring the reliability of critical components.
-   **`lib/main.dart`:** The entry point of the Flutter application.

## API Key

**Important:** You **must** obtain your own API key from [NewsAPI](https://newsapi.org/) and insert it into `lib/services/api_service.dart` as described in the Setup instructions. The app will not function correctly without a valid API key.

## Running Tests

To run the unit tests for the project, use the following command in your terminal:

```bash
flutter test