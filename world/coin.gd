class_name Coin
extends Area2D


@export var score: int = 100


func _on_powerup_pickup():
	EventBus.coin_picked_up.emit(score)
