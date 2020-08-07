# Contact List Demo

## Introduction

A contact list management app using REST API and BLoC pattern.

## How to use

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/akhilmorya/contacts-list-demo
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

## Functionalities

* Add Contact
* View Contact
* Edit Contact
* Delete Contact

## Dependencies Used

* validators            - ^2.0.0
* shared_preferences    - ^0.5.8
* uuid                  - 2.2.0
* http                  - ^0.12.2
* loading_overlay       - ^0.2.1

## Folder Structure

```
lib/
|- bloc/
    |- contact_bloc.dart
|- api_provider/
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
    |- add_contact_page.dart
    |- edit_contact_page.dart
    |- home_page.dart
    |- view_contact_page.dart
|- main.dart

```

## Conclusion

The test demo has been done in flutter. Supported on all iOS and android devices.