class_name Coin
extends PowerUp


func _on_powerup_pickup():
	EventBus.world.coin_picked_up.emit()
	print("coin picked up")
