package main

import (
	"expense-backend/database"
	"expense-backend/routes"
	"github.com/gin-gonic/gin"
)

func main() {
	database.ConnectDB()
	r := gin.Default()
	routes.SetupRoutes(r)
	r.Run(":8080")
}
