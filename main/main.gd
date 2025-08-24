extends Node


@onready var pause_menu: Control = $Interface/PauseMenu
@onready var options_menu: Control = $Interface/OptionsMenu
@onready var level_finished_screen: Control = $Interface/LevelFinishedScreen
@onready var game_over_screen: Control = $Interface/GameOverScreen


func _ready() -> void:
	EventBus.world.game_started.connect(new_game)
	
	pause_menu.hide()
	options_menu.hide()
	level_finished_screen.hide()
	game_over_screen.hide()
	
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
	pause_menu.open()
	
func resume_game():
	get_tree().paused = false
	pause_menu.close()
	
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
