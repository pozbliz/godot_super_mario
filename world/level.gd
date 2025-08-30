extends Node2D

@onready var player_spawn: Marker2D = $PlayerSpawnPoint


func _ready() -> void:
	EventBus.player_died.connect(_on_player_died)

func get_player_spawn_position() -> Vector2:
	return player_spawn.global_position
	
func _on_player_died():
	for block in get_tree().get_nodes_in_group("powerup_blocks"):
		block.reset_usage()
