class_name Coin
extends PowerUp


func apply_effect(player: Player) -> void:
	EventBus.world.coin_picked_up.emit()
