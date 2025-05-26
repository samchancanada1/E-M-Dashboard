# Use official Golang image
FROM golang:1.21

# Set working directory
WORKDIR /app

# Copy go.mod and go.sum first
COPY go.mod ./
RUN go mod tidy

# Copy the rest of the application
COPY . .

# Build the Go application
RUN go build -o server main.go

# Expose the server port
EXPOSE 8080

# Start the server
CMD ["./server"]
