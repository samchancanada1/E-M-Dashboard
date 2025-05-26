package main

import (
	"expense-backend/database"
	"expense-backend/routes"
	"github.com/gin-gonic/gin"

	// Swagger
    _ "expense-backend/docs"
 	ginSwagger "github.com/swaggo/gin-swagger"
    swaggerFiles "github.com/swaggo/files"
)


// @title Expense Management API
// @version 1.0
// @description This is a sample server for managing expenses and users.
// @host localhost:8080
// @BasePath /

func main() {
	database.ConnectDB()
	r := gin.Default()

   // Swagger route
    r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

	routes.SetupRoutes(r)
	r.Run(":8080")
}
