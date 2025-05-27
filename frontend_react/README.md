# Frontend (React)

This directory contains the React-based web frontend for the E-M-Dashboard project.

## 🛠 Tech Stack

- **React**
- **JavaScript / JSX**
- **HTML/CSS**
- **Docker**

## 🚀 Development Setup

If you're running the frontend locally (outside Docker):

```bash
# Navigate to the directory
cd frontend_react

# Install dependencies
npm install

# Start the development server
npm start
```

The app will be available at [http://localhost:3000](http://localhost:3000).

## 🐳 Docker Instructions

This frontend is also part of the main Docker Compose setup. To run via Docker:

```bash
# From the root project directory (E-M-Dashboard)
docker-compose up --build
# or
docker compose up --build
```

It will be served at [http://localhost:3000](http://localhost:3000).

## 📁 Directory Structure

```
frontend_react/
├── public/           # Static assets and HTML template
├── src/              # Main React application source code
│   ├── components/   # Reusable UI components
│   ├── pages/        # Page components
│   └── App.js        # App entry point
├── Dockerfile        # Docker setup for this React app
├── package.json      # Dependency list and scripts
└── README.md         # Project documentation
```

## 🔗 Backend API

Make sure the backend service is running at `http://localhost:8080` or update the API base URL in the source code if needed.
