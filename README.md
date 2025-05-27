# E-M-Dashboard

An Expense Management Dashboard with both Flutter and React frontend options, powered by a backend server and PostgreSQL database.

## 🛠 Tech Stack

- **Frontend (Flutter Web)**: Dart, Flutter
- **Frontend (React)**: React (structure referenced)
- **Backend**: Go (Golang)
- **Database**: PostgreSQL
- **Containerization**: Docker & Docker Compose

## 🚀 Getting Started with Docker

To run the application with Docker:

```bash
# Navigate into the project root directory
cd E-M-Dashboard

# Build and start all services
# Use the appropriate command based on your Docker version:
docker-compose up --build
# or
docker compose up --build
```

This will start:
- `backend` on [http://localhost:8080](http://localhost:8080)
- `frontend_react` on [http://localhost:3000](http://localhost:3000)
- `frontend_flutter` on [http://localhost:4000](http://localhost:4000)
- `PostgreSQL` on port `5432`

## 🔌 API Endpoints

### 👤 User Endpoints
| Method | Endpoint             | Description            |
|--------|----------------------|------------------------|
| GET    | `/users`             | Get all users          |
| POST   | `/users`             | Create a new user      |
| PUT    | `/users/:id`         | Update a user by ID    |
| DELETE | `/users/:id`         | Delete a user by ID    |

### 💰 Transaction Endpoints
| Method | Endpoint                             | Description                     |
|--------|--------------------------------------|---------------------------------|
| GET    | `/users/:id/transactions`            | Get transactions for a user     |
| POST   | `/transactions`                      | Create a new transaction        |
| PUT    | `/transactions/:id`                  | Update a transaction by ID      |
| DELETE | `/transactions/:id`                  | Delete a transaction by ID      |


## 📘 Swagger Documentation

Once the backend is available, you can access the interactive API documentation (if Swagger is set up) at:

```
http://localhost:8080/api-docs
```

This provides a web UI to explore and test the API endpoints.

## 📂 Project Structure

```
E-M-Dashboard/
├── frontend_flutter/      # Flutter web app
├── frontend_react/        # React frontend (expected)
├── backend/               # Backend server (missing)
├── docker-compose.yml     # Docker service definitions
└── README.md
```
