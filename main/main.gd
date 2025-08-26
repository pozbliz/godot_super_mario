extends Node


var current_lives: int
var max_lives: int = 3
var current_level: Node = null
var level1_scene: PackedScene = preload("res://world/level1.tscn")

@onready var player: Player = $"../World/Player"
@onready var level: Node2D = $"../World/Level"


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	EventBus.world.main_menu_opened.connect(exit_to_menu)
	EventBus.player.player_died.connect(_on_player_died)
	
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
	EventBus.player.lives_updated.emit(current_lives)
	
	load_level(level1_scene)
	
func pause_game():
	get_tree().paused = true
	EventBus.world.game_paused.emit()
	
func resume_game():
	get_tree().paused = false
	EventBus.world.game_resumed.emit()
	
func load_level(level_scene: PackedScene):
	if current_level:
		current_level.queue_free()
		
	current_level  = level_scene.instantiate()
	level.add_child(current_level)

	player.global_position = current_level.get_player_spawn_position()
	player.is_dead = false
	
func _on_player_died():
	current_lives -= 1
	EventBus.player.lives_updated.emit(current_lives)
	await get_tree().create_timer(2).timeout
	if current_lives <= 0:
		game_over()
	else:
		respawn_player()
		
func respawn_player():
	player.global_position = current_level.get_player_spawn_position()
	player.is_dead = false
	player.state_machine.set_process(true)
	player.state_machine.set_physics_process(true)
	
func game_over():
	EventBus.world.game_over.emit()
	
func exit_to_menu():
	get_tree().change_scene_to_file("res://ui/ui.tscn")
