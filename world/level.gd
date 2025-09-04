extends Node2D


var last_time_left: int = -1

@onready var player_spawn: Marker2D = $PlayerSpawnPoint
@onready var timer: Timer = $Timer


func _ready() -> void:
	EventBus.player_died.connect(_on_player_died)
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	
func _process(delta: float) -> void:
	var seconds_left: int = int(ceil(timer.time_left))
	if seconds_left != last_time_left:
		last_time_left = seconds_left
		EventBus.timer_updated.emit(seconds_left)

func get_player_spawn_position() -> Vector2:
	return player_spawn.global_position
	
func _on_player_died():
	for block in get_tree().get_nodes_in_group("powerup_blocks"):
		block.reset_usage()
		
func _on_timer_timeout():
	EventBus.level_timeout.emit()
