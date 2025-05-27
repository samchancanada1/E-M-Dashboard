
# Backend - E-M Dashboard

This folder contains the backend service for the E-M Dashboard application.

## 🚀 Tech Stack

- **Language**: Go (Golang)
- **Framework**: net/http
- **Database**: Likely PostgreSQL (based on common setups, confirm from `database/connect.go`)
- **API Docs**: Swagger (`docs/swagger.yaml`)
- **Architecture**: MVC-style with Controllers, Models, and Routes
- **Containerization**: Docker

## 🐳 Docker Instructions

To build and run the backend service using Docker:

```bash
# Build Docker image
docker build -t em-dashboard-backend .

# Run the container (adjust port mapping as needed)
docker run -p 8080:8080 em-dashboard-backend
```

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

> For full details, refer to `docs/swagger.yaml` or import it into Swagger UI.

## 📁 Folder Structure

- `controllers/` — Request handlers
- `models/` — Data models
- `routes/` — Router and endpoint registration
- `docs/` — Swagger documentation
- `database/` — DB connection logic
- `main.go` — Entry point

---

Generated for internal documentation purposes.
