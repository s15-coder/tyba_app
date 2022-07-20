# Tyba App

A mobile application where you can search the restaurants according to the city you want.

## Getting Started

This application works based on BLoC state management library to consume the manage the different data used along of the application. It's connected to an [API](https://docs.mapbox.com/api/overview/) to get the restaurants according to the city.

## How to use

**Step 1:**

Download or clone this repo by using the link below:

``https://github.com/s15-coder/juno_app.git``

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:}

``flutter pub get ``

**Step 3:**

Let's run the application!

## Libraries & Tools Used
 
  * [Equatable](https://pub.dev/packages/equatable): Makes easier compare different objects that have exactly the same properties.
  * [Flutter Bloc](https://pub.dev/packages/flutter_bloc): Provide us the BLoC state management methods.
  * [Font Awesome Flutter](https://pub.dev/packages/font_awesome_flutter): Additional iconography to the default.
  * [Dio](https://pub.dev/packages/dio): Allows make network requests.
  * [Cloud Firestore](https://pub.dev/packages/cloud_firestore): Service to save info, in this case the users with their names.
  * [Firebase Auth](https://pub.dev/packages/firebase_auth): Service to athenticate users in a secure way since the application.
  * [Hive](https://pub.dev/packages/hive): Save information in the storage of the device, in this case was used to save the user information.
  * [Hive Flutter](https://pub.dev/packages/hive_flutter): Extension for [Hive](https://pub.dev/packages/hive).

  

  ## Folder Structure

  Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

This is the estructure used specifically in this project:

```
lib/
|- bloc
|- helpers
|- models
|- pages
|- routes
|- services
|- widgets
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- bloc - Contains the different BLoCs used along the application
3- helpers - Code that may be used in different parts of the app to complement functionality.
4- models - Contains all the models or templates of the data used along the app.
5- pages - Contains the files where are sited the app screens.
6- routes - All functionality related to navition inside the app.
7- services - Contains the implementation of determined features in a comprehensible way.
9- widgets - UI components of the application which may be reused.
