# Use official Golang image
FROM golang:1.23

# Set working directory
WORKDIR /app

# Copy go.mod and go.sum separately to leverage Docker cache
COPY go.mod go.sum ./

# Download and tidy modules
RUN go mod tidy
RUN go mod download

# Copy the rest of the code
COPY . .

# Build the Go application
RUN go build -o server main.go

# Expose the server port
EXPOSE 8080

# Start the server
CMD ["./server"]
