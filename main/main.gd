extends Node


var current_lives: int
var max_lives: int = 3


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	EventBus.world.game_started.connect(new_game)
	EventBus.world.main_menu_opened.connect(exit_to_menu)

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
	
func pause_game():
	get_tree().paused = true
	EventBus.world.game_paused.emit()
	
func resume_game():
	get_tree().paused = false
	EventBus.world.game_resumed.emit()
	
func game_over():
	$Player.set_process(false)
	$Player.set_physics_process(false)
	$Player.set_process_unhandled_input(false)
	$GameOverScreen.show()
	
func exit_to_menu():
	get_tree().change_scene_to_file("res://ui/ui.tscn")
