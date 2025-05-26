package controllers

import (
	"expense-backend/database"
	"expense-backend/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

func CreateTransaction(c *gin.Context) {
	var tx models.Transaction
	if err := c.ShouldBindJSON(&tx); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	if err := database.DB.Create(&tx).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, tx)
}

func GetUserTransactions(c *gin.Context) {
	var transactions []models.Transaction
	userID := c.Param("id")
	database.DB.Where("user_id = ?", userID).Find(&transactions)
	c.JSON(http.StatusOK, transactions)
}

func UpdateTransaction(c *gin.Context) {
	var tx models.Transaction
	id := c.Param("id")
	if err := database.DB.First(&tx, id).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Transaction not found"})
		return
	}
	if err := c.ShouldBindJSON(&tx); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	database.DB.Save(&tx)
	c.JSON(http.StatusOK, tx)
}

func DeleteTransaction(c *gin.Context) {
	id := c.Param("id")
	database.DB.Delete(&models.Transaction{}, id)
	c.JSON(http.StatusOK, gin.H{"message": "Transaction deleted"})
}
