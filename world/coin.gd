class_name Coin
extends Area2D


func _on_powerup_pickup():
	EventBus.world.coin_picked_up.emit()
