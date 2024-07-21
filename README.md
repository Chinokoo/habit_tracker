# Habit Tracker

A Flutter project for tracking habits.

## Description

This Habit Tracker is a mobile application built with Flutter. It allows users to create, track, and manage their daily habits.

## Features

- Habit creation and tracking
- Theme customization (light/dark mode)
- Persistent data storage using a local database
- Heatmap view to visualize habit completion progress

## Getting Started

### Prerequisites

- Flutter SDK
- Dart
- Android Studio or VS Code with Flutter extensions

### Installation

1. Clone the repository
2. In your terminal or cmd run `flutter pub get` to install dependencies
3. Run the app using `flutter run`

## Project Structure

- `lib/main.dart`: Entry point of the application
- `lib/pages/home_page.dart`: Main screen of the app
- `lib/database/habit_database.dart`: Database operations for habits
- `lib/themes/theme_provider.dart`: Theme management

## Dependencies

- provider: For state management
- isar_flutter_libs: For local database operations
- path_provider: For accessing device file system

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).
