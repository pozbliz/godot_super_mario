class_name PowerupBlock
extends StaticBody2D


@export var powerup_scene: PackedScene

var used: bool = false


func _ready() -> void:
	$Area2D.body_entered.connect(_on_player_hit_from_below)

func _on_player_hit_from_below(body: CharacterBody2D) -> void:
	if not body is Player:
		return

	if used:
		return
		
	used = true
	#$Sprite2D.texture = preload() # add texture for used block
	if powerup_scene:
		var powerup = powerup_scene.instantiate()
		get_parent().add_child(powerup)
		powerup.global_position = global_position + Vector2(0, -16) # spawn above
