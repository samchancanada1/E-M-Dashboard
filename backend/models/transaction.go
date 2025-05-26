package models

import "gorm.io/gorm"

type Transaction struct {
	gorm.Model
	UserID   uint    `json:"user_id"`
	Type     string  `json:"type"`
	Category string  `json:"category"`
	Amount   float64 `json:"amount"`
}
