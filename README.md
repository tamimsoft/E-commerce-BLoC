# Flutter E-Commerce Project Documentation

## Overview
This document provides an overview of the dependencies used in a Flutter e-commerce project. These dependencies enable essential functionalities such as state management, database handling, HTTP requests, and UI enhancements.

---

## Dependencies
Below is a list of dependencies used in this project, categorized by their purpose:

### **Core Dependencies**
1. **intl: ^0.19.0**
   - Provides internationalization and localization support, including date formatting and translation.

2. **http: ^1.2.2**
   - Simplifies making HTTP requests to APIs.

3. **logger: ^2.5.0**
   - A logger utility to log messages during development for debugging purposes.

### **UI Enhancements**
1. **cached_network_image: ^3.4.1**
   - Enables efficient image loading and caching.

2. **image_picker: ^1.1.2**
   - Facilitates picking images from the gallery or camera.

3. **flutter_svg: ^2.0.10+1**
   - Renders SVG images in Flutter applications.

4. **carousel_slider: ^5.0.0**
   - Creates image carousels and sliders.

5. **pinput: ^5.0.0**
   - Provides a customizable input field, typically used for PIN entry.

6. **shimmer: ^3.0.0**
   - Displays shimmer effects to indicate loading states.

7. **another_flushbar: ^1.12.30**
   - Displays customizable snack bars and notifications.

### **State Management**
1. **flutter_bloc: ^8.1.6**
   - A predictable state management library that uses the BLoC (Business Logic Component) pattern.

2. **equatable: ^2.0.5**
   - Simplifies equality comparisons, especially when used with BLoC.

### **Local Database**
1. **flutter_secure_storage: ^9.2.2**
   - Securely stores sensitive data like tokens and credentials.

2. **drift: ^2.23.1**
   - A reactive persistence library for handling SQL databases in Flutter.

3. **drift_flutter: ^0.2.4**
   - Integrates Drift with Flutter for database management.

4. **path_provider: ^2.1.5**
   - Provides paths to commonly used directories like documents and temporary files.

### **Notifications**
1. **flutter_local_notifications: ^18.0.1**
   - Schedules and shows local notifications.

---

## Project Highlights
This e-commerce project utilizes these dependencies to:
- Fetch and display product data from APIs.
- Cache and display images efficiently.
- Implement a responsive and interactive UI with animations and effects.
- Manage application state predictably with BLoC.
- Store and secure user data using local databases.
- Provide local notification functionality.

---

## Getting Started
To get started with this project:
1. Clone the repository.
2. Install the dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

---

## Author
Tamim Hasan

