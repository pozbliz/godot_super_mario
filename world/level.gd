extends Node2D

@onready var player_spawn: Marker2D = $PlayerSpawnPoint

func get_player_spawn_position() -> Vector2:
	return player_spawn.global_position
