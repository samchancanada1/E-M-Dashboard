package models

import "time"

type User struct {
	ID        uint      `gorm:"primaryKey" json:"id"`
	CreatedAt time.Time `json:"created_at"`
	UpdatedAt time.Time `json:"updated_at"`

	Name  string `json:"name"`
	Email string `json:"email"`

	Transactions []Transaction `gorm:"foreignKey:UserID" json:"transactions"`

	// Virtual fields, not stored in DB
	TotalIncome  float64 `gorm:"-" json:"total_income"`
	TotalExpense float64 `gorm:"-" json:"total_expense"`
}
