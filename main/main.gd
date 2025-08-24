extends Node


func _ready() -> void:
	EventBus.world.game_started.connect(new_game)	
	EventBus.world.game_resumed.connect(resume_game)
	EventBus.world.options_menu_opened.connect(open_options)
	EventBus.world.main_menu_opened.connect(exit_to_menu)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):
		if get_tree().paused:
			resume_game()
		else:
			pause_game()

func _process(_delta: float) -> void:
	pass

func new_game():
	pass
	
func pause_game():
	get_tree().paused = true
	EventBus.world.pause_requested.emit()
	
func resume_game():
	get_tree().paused = false
	
func open_options():
	pass
	# TODO: options menu
	
func game_over():
	$Player.set_process(false)
	$Player.set_physics_process(false)
	$Player.set_process_unhandled_input(false)
	$GameOverScreen.show()
	
func exit_to_menu():
	get_tree().change_scene_to_file("res://ui/ui.tscn")
