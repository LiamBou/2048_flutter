# 2048 Game with Flutter
<p align="center">
  <img src="https://github.com/LiamBou/2048_flutter/blob/main/lib/assets/background_presentation.png" alt="Presentation Image"/>
</p>

## Overview

This project is a Flutter implementation of the popular 2048 game. The game is built using Dart and leverages the Flutter framework for the UI. The game logic and state management are handled using the `Provider` package.

## Features

- Swipe to move tiles in four directions (up, down, left, right).
- Combine tiles with the same number to create larger numbers.
- Keep track of the current score and the best score using *Providers*.
- Best score saved when app closed using *SharedPreferences*
- Reset the game to start over.

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Included with Flutter
- Android Studio or Visual Studio Code: Recommended for development

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/LiamBou/2048_flutter.git
   cd 2048_flutter
2. Install the dependencies:
   ```sh
   flutter pub get
   ```
3. Run the app:
   ```
   flutter run
   ```
## Project Structure
- **lib/**: Contains the main source code for the Flutter app.
- **widgets/**: Contains the custom widgets used in the app.
- **models/**: Contains the data models and state management logic.
- **assets/**: Contains the images and other assets used in the app.

## Key Files
- **lib/main.dart**: Entry point of the application.
- **lib/widgets/board_widget.dart**: Contains the main game board widget.
- **lib/models/score_model.dart**: Contains the score model and state management logic.

## Dependencies
- **provider**: State management
- **shared_preferences**: Persistent storage

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any changes.
