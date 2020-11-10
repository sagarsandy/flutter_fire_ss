# flutter_fire_ss

Firebase Console:
1. Create one project, if u don't have any
2. Create one app(android/ios) inside the project and download the respective file
3. Create database(cloud firestore native) inside the project.
4. Modify the database rules to public for now.


Inside the flutter project:
1. Need to include google-services.json file created from console firebase
2. open android/build.gradle and add
    classpath 'com.google.gms:google-services:4.3.4' in dependencies
3. open android/app/build.gradle and add
    apply plugin: 'com.google.gms.google-services'
    also add 
        1. multiDexEnabled true in defaultConfig
        2. dependencies {
                   implementation 'com.android.support:multidex:1.0.3'
               }  after the defaultConfig
       these 2 steps might not be required, if u didn't find any error.
4. add cloud_firestore in pubspec.yaml file and run packages get



A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
