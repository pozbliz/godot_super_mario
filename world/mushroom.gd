class_name Mushroom
extends PowerUp


var growth_level: int = 1


func apply_effect(player: Player) -> void:
	player.grow(growth_level)
