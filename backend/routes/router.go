package routes

import (
	"expense-backend/controllers"
	"github.com/gin-gonic/gin"
)

func SetupRoutes(r *gin.Engine) {
	r.GET("/users", controllers.GetUsers)
	r.POST("/users", controllers.CreateUser)
	r.PUT("/users/:id", controllers.UpdateUser)
	r.DELETE("/users/:id", controllers.DeleteUser)

	r.GET("/users/:id/transactions", controllers.GetUserTransactions)
	r.POST("/transactions", controllers.CreateTransaction)
	r.PUT("/transactions/:id", controllers.UpdateTransaction)
	r.DELETE("/transactions/:id", controllers.DeleteTransaction)
}
