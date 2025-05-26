package controllers

import (
	"expense-backend/database"
	"expense-backend/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

// CreateUser godoc
// @Summary Create a new user
// @Description Add a user by providing name and email
// @Tags users
// @Accept json
// @Produce json
// @Param user body models.User true "User to create"
// @Success 200 {object} models.User
// @Failure 400 {object} swagger.ErrorResponse
// @Failure 500 {object} swagger.ErrorResponse
// @Router /users [post]
func CreateUser(c *gin.Context) {
	var user models.User
	if err := c.ShouldBindJSON(&user); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := database.DB.Create(&user).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, user)
}

// GetUsers godoc
// @Summary List users with income/expense summary
// @Description Get all users with total income and total expense
// @Tags users
// @Produce json
// @Success 200 {array} models.User
// @Failure 500 {object} swagger.ErrorResponse
// @Router /users [get]
func GetUsers(c *gin.Context) {
	var users []models.User
	database.DB.Preload("Transactions").Find(&users)

	for i := range users {
		var income, expense float64
		for _, tx := range users[i].Transactions {
			if tx.Type == "income" {
				income += tx.Amount
			} else if tx.Type == "expense" {
				expense += tx.Amount
			}
		}
		users[i].TotalIncome = income
		users[i].TotalExpense = expense
	}

	c.JSON(http.StatusOK, users)
}

// UpdateUser godoc
// @Summary Update a user
// @Description Update user info by ID
// @Tags users
// @Accept json
// @Produce json
// @Param id path int true "User ID"
// @Param user body models.User true "Updated user info"
// @Success 200 {object} models.User
// @Failure 400 {object} swagger.ErrorResponse
// @Failure 404 {object} swagger.ErrorResponse
// @Router /users/{id} [put]
func UpdateUser(c *gin.Context) {
	var user models.User
	id := c.Param("id")
	if err := database.DB.First(&user, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "User not found"})
		return
	}
	if err := c.ShouldBindJSON(&user); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	database.DB.Save(&user)
	c.JSON(http.StatusOK, user)
}

// DeleteUser godoc
// @Summary Delete a user
// @Description Delete a user by ID
// @Tags users
// @Produce json
// @Param id path int true "User ID"
// @Success 200 {object} swagger.MessageResponse
// @Failure 404 {object} swagger.ErrorResponse
// @Router /users/{id} [delete]
func DeleteUser(c *gin.Context) {
	id := c.Param("id")
	database.DB.Delete(&models.User{}, id)
	c.JSON(http.StatusOK, gin.H{"message": "User deleted"})
}
