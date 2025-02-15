# GDG Fest App

A Flutter-based mobile application for managing and attending GDG (Google Developer Groups) events and festivals.

## Features

- 🎫 Event Registration & Ticketing

  - Browse upcoming GDG events
  - Register for events with just a few taps
  - Digital ticket management
  - QR code generation for easy check-in

- 👥 User Profiles

  - Customizable user profiles
  - Track attended events
  - Manage event registrations
  - Connect with other attendees

- 📅 Event Schedule

  - Detailed event timelines
  - Session tracking
  - Custom schedule builder
  - Reminder notifications

- 🗺️ Venue Navigation
  - Interactive venue maps
  - Session room locations
  - Points of interest
  - Offline map support

## Installation

1. **Prerequisites**

   - Flutter SDK (latest version)
   - Android Studio or VS Code
   - Git

2. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/gdgfest.git
   cd gdgfest
   ```

3. **Install Dependencies**

   ```bash
   flutter pub get
   ```

4. **Run the App**
   ```bash
   flutter run
   ```

The compiled APK can be found in the `build/app/outputs/apk/` directory after building the project.

## Usage Guide

### For Attendees

1. Download and install the app
2. Create your profile
3. Browse available events
4. Register for events of interest
5. Access your digital tickets
6. Build your personal schedule

### For Event Organizers

1. Log in with organizer credentials
2. Access the admin dashboard
3. Create and manage events
4. Monitor registrations
5. Generate attendance reports

## Development Setup

1. **Environment Setup**

   ```bash
   flutter doctor
   ```

   Ensure all checkmarks are green

2. **Configuration**

   - Create a `config.dart` file in `lib/config/`
   - Add your API keys and endpoints

3. **Run Tests**
   ```bash
   flutter test
   ```

## Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Tech Stack

- Flutter
- Dart
- Firebase
- Google Maps API
- Provider State Management

## Support

For support, email support@gdgfest.com or join our Slack channel.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Made with ❤️ by GDG Community
