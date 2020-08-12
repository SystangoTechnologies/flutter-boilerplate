# Flutter Boilerplate

## Introduction

A boilerplate project for flutter.

## How to use

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/SystangoTechnologies/RN-Boilerplate.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

**For iOS only:**

```
cd ios && pod install
```

**Step 4:**

To run the app on device or simulator, execute the following command.

```
flutter run -d <deviceId>
```

## Dependencies Used

* validators            - ^2.0.0
* shared_preferences    - ^0.5.8
* uuid                  - 2.2.0
* http                  - ^0.12.2
* loading_overlay       - ^0.2.1

## Features

* Generic API structure.
* Test Cases.
  * Unit test cases.
  * Widget test cases.

## Testing

To run all the test cases of all the test files, execute the following command.
```
flutter test
```

To run a particular test case file, you have to specify the file path and execute the following command.
```
flutter test <file_path>
```

## Folder Structure

```
test/
|- unit_test.dart
|- widget_test.dart
lib/
|- bloc
    |- contact_bloc.dart
|- api_provider
    |- base_api_provider.dart
    |- contact_api_provider.dart
|- constants
    |- endpoints.dart
    |- headers.dart
    |- strings.dart
|- model
    |- contact.dart
|- repository
    |- contact_repository.dart
|- ui
    |- home_page.dart
    |- test_cases_demo_page.dart
|- utils
    |- contact_utils.dart
    |- guid_utils.dart
    |- validators.dart
|- main.dart

```

## Conclusion

This is a boilerplate project made in flutter. Supported on all iOS and android devices.