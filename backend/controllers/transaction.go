package controllers

import (
	"expense-backend/database"
	"expense-backend/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

// CreateTransaction godoc
// @Summary Add a transaction
// @Description Add income or expense for a user
// @Tags transactions
// @Accept json
// @Produce json
// @Param transaction body models.Transaction true "Transaction to create"
// @Success 200 {object} swagger.TransactionResponse
// @Failure 400 {object} swagger.ErrorResponse
// @Failure 500 {object} swagger.ErrorResponse
// @Router /transactions [post]
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

// GetUserTransactions godoc
// @Summary Get all transactions of a user
// @Description List all income and expenses by user ID
// @Tags transactions
// @Produce json
// @Param id path int true "User ID"
// @Success 200 {array} swagger.TransactionResponse
// @Failure 500 {object} swagger.ErrorResponse
// @Router /users/{id}/transactions [get]
func GetUserTransactions(c *gin.Context) {
	var transactions []models.Transaction
	userID := c.Param("id")
	database.DB.Where("user_id = ?", userID).Find(&transactions)
	c.JSON(http.StatusOK, transactions)
}

// UpdateTransaction godoc
// @Summary Update a transaction
// @Description Update a transaction by ID
// @Tags transactions
// @Accept json
// @Produce json
// @Param id path int true "Transaction ID"
// @Param transaction body models.Transaction true "Updated transaction"
// @Success 200 {object} swagger.TransactionResponse
// @Failure 400 {object} swagger.ErrorResponse
// @Failure 404 {object} swagger.ErrorResponse
// @Router /transactions/{id} [put]
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

// DeleteTransaction godoc
// @Summary Delete a transaction
// @Description Remove a transaction by ID
// @Tags transactions
// @Produce json
// @Param id path int true "Transaction ID"
// @Success 200 {object} swagger.MessageResponse
// @Failure 404 {object} swagger.ErrorResponse
// @Router /transactions/{id} [delete]
func DeleteTransaction(c *gin.Context) {
	id := c.Param("id")
	database.DB.Delete(&models.Transaction{}, id)
	c.JSON(http.StatusOK, gin.H{"message": "Transaction deleted"})
}
