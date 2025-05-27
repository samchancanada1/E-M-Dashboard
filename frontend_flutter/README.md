# Frontend (Flutter Web)

This directory contains the Flutter web frontend for the E-M-Dashboard project.

## 🛠 Tech Stack

- **Flutter**
- **Dart**
- **Docker**

## 🚀 Development Setup

If you're running the Flutter web frontend locally (outside Docker):

```bash
# Navigate to the directory
cd frontend_flutter

# Install dependencies
flutter pub get

# Run in web mode
flutter run -d chrome
```

## 🐳 Docker Instructions

This frontend is also part of the main Docker Compose setup. To run via Docker:

```bash
# From the root project directory (E-M-Dashboard)
docker-compose up --build
# or
docker compose up --build
```

It will be served at [http://localhost:4000](http://localhost:4000).

## 📁 Directory Structure

```
frontend_flutter/
├── lib/              # Flutter Dart source files
│   ├── models/       # Data models
│   ├── providers/    # State management
│   ├── repositories/ # API interaction
│   ├── services/     # HTTP services
│   ├── widgets/      # Reusable UI components
│   └── main.dart     # Entry point
├── web/              # Web-specific assets
├── Dockerfile        # Docker setup for this Flutter app
├── pubspec.yaml      # Dependency list and project metadata
└── README.md         # Project documentation
```

## 🔗 Backend API

Ensure the backend service is running at `http://localhost:8080` or update `config.dart` with the correct base URL.
