# airsense-test
# Getting Started with Flutter

This guide will help you install Flutter and run this app, as well as set up your development environment for both Android and iOS.

## Prerequisites

Before you begin, make sure you have the following prerequisites installed on your system:

- Flutter
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- Android SDK

## Installing Flutter

1. Open a terminal.

2. Clone the Flutter repository from GitHub by running the following command:

    ```bash
    git clone https://github.com/flutter/flutter.git
    ```

3. Add the Flutter binary directory to your system path by appending the following line to your `~/.bashrc` file:

    ```bash
    export PATH="$PATH:`pwd`/flutter/bin"
    ```

4. Apply the changes to your current session by running:

    ```bash
    source ~/.bashrc
    ```

5. Verify that Flutter is installed correctly by running:

    ```bash
    flutter doctor
    ```

Alternatively you can follow the official flutter [guide](https://docs.flutter.dev/get-started/install) to install flutter for other operating systems.

## Setting Up Android Development Environment

1. Install Android Studio by downloading it from the [official website](https://developer.android.com/studio).

2. Follow the installation instructions provided on the website.

3. Open Android Studio and install the Android SDK and any necessary platform tools.

4. Configure Flutter to use the Android SDK by running:

    ```bash
    flutter config --android-sdk <path_to_android_sdk>
    ```

## Setting Up iOS Development Environment (macOS Only)

1. Install Xcode from the Mac App Store.

2. Open Xcode and accept the license agreement.

3. Install additional components if prompted.

## Running and Installing the Flutter App
You need to clone the app to your machine to be able to install and run the app.

### Cloning the repository
1. Navigate to the directory where you would like to save the repository
2. Run ```git clone git@github.com:raskovnik/airsense-test.git``` to clone the repository to your machine.

### Installing the flutter app
1. Navigate to the cloned app directory in the terminal.

2. Connect your Android device to your computer via USB and ensure that USB debugging is enabled.

3. Run the following command to install and launch the app:

    ```bash
    flutter run
    ```
4. A menu will appear asking you to select the device you would wish to run the app on, enter the number next to the device of choice and click enter.
   
5. To run your app on an iOS simulator (macOS only), open the iOS simulator from Xcode and run:

    ```bash
    flutter run
    ```

Congratulations! You have successfully installed and run the app.

## How to use the app
Once the application opens, it fetches the data from the API, and displays a temperature graph of the sensor from the last 7 days. To get updated data of the sensor, pull down to refresh!

## App Architecture
The app uses the BLoC(Business Logic Component) architecture which provides a structured way to separate the presentation layer from the business logic layer.