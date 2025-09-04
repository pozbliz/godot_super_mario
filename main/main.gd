extends Node


var current_lives: int
var max_lives: int = 3
var score: int = 0
var current_level: Node = null
var next_level: int = 1
var level1_scene: PackedScene = preload("res://world/level1.tscn")
var levels: Dictionary = {
	1: "res://world/level1.tscn"
}

@onready var player: Player = $"../World/Player"
@onready var level: Node2D = $"../World/Level"


func _ready() -> void: # TODO: add parallax background
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	EventBus.main_menu_opened.connect(exit_to_menu)
	EventBus.player_died.connect(_on_player_died)
	EventBus.level_finished.connect(_on_level_finished)
	EventBus.enemy_died.connect(_on_enemy_died)
	EventBus.coin_picked_up.connect(_on_coin_picked_up)
	EventBus.level_timeout.connect(_on_level_timeout)
	
	new_game()
	

func _process(_delta: float) -> void:
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):
		if get_tree().paused:
			resume_game()
		else:
			pause_game()

func new_game():
	current_lives = max_lives
	player.is_dead = false
	player.set_process(true)
	player.set_physics_process(true)
	player.set_process_unhandled_input(true)
	EventBus.lives_updated.emit(current_lives)
	
	load_level(next_level, level1_scene)
	
func pause_game():
	get_tree().paused = true
	EventBus.game_paused.emit()
	
func resume_game():
	get_tree().paused = false
	EventBus.game_resumed.emit()
	
func load_level(next_level, level_scene: PackedScene):
	if current_level:
		current_level.queue_free()
		
	current_level  = level_scene.instantiate()
	level.add_child(current_level)

	player.global_position = current_level.get_player_spawn_position()
	player.is_dead = false
	
	EventBus.level_started.emit(next_level)
	
func _on_player_died():
	current_lives -= 1
	EventBus.lives_updated.emit(current_lives)
	await get_tree().create_timer(2).timeout
	if current_lives <= 0:
		game_over()
	else:
		respawn_player()
		
func _on_enemy_died(enemy_score: int):
	score += enemy_score
	EventBus.score_changed.emit(score)
	
func _on_coin_picked_up(coin_score: int):
	score += coin_score
	EventBus.score_changed.emit(score)
		
func respawn_player():
	player.global_position = current_level.get_player_spawn_position()
	player.respawn()
	player.state_machine.set_process(true)
	player.state_machine.set_physics_process(true)
	EventBus.player_respawned.emit(next_level)
	
func _on_level_finished():
	player.state_machine.set_process(false)
	player.state_machine.set_physics_process(false)
	next_level += 1
	
func _on_level_timeout():
	game_over()
	
func game_over():
	EventBus.game_over.emit()
	
func exit_to_menu():
	get_tree().change_scene_to_file("res://ui/ui.tscn")
