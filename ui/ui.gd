extends CanvasLayer


signal game_started

enum UIState { MAIN_MENU, OPTIONS_MENU, GAMEPLAY }

var current_state: UIState = UIState.MAIN_MENU
var previous_state: UIState = current_state


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$MainMenu/MarginContainer/VBoxContainer/StartGameButton.pressed.connect(start_game)
	$MainMenu/MarginContainer/VBoxContainer/HowToPlayButton.pressed.connect(open_how_to_play_menu)
	$MainMenu/MarginContainer/VBoxContainer/OptionsButton.pressed.connect(open_options_menu)
	$MainMenu/MarginContainer/VBoxContainer/ExitGameButton.pressed.connect(_on_exit_game_button_pressed)
	$HowToPlayMenu/MarginContainer/VBoxContainer/BackButton.pressed.connect(_on_back_button_pressed)
	$OptionsMenu/MarginContainer/VBoxContainer/BackButton.pressed.connect(_on_back_button_pressed)
	
	open_main_menu()
	
func _gui_input(event):
	if event.is_action_pressed("ui_up"):
		event.consume()
	elif event.is_action_pressed("ui_down"):
		event.consume()
	
func _on_back_button_pressed():
	if previous_state == UIState.MAIN_MENU:
		open_main_menu()
	
func _on_exit_game_button_pressed():
	get_tree().quit()
	
func open_main_menu():
	current_state = UIState.MAIN_MENU
	$MainMenu.show()
	$OptionsMenu.hide()
	$HowToPlayMenu.hide()
	get_tree().paused = true
	
	$MainMenu/MarginContainer/VBoxContainer/StartGameButton.grab_focus()

func open_options_menu():
	current_state = UIState.OPTIONS_MENU
	$MainMenu.hide()
	$OptionsMenu.show()
	get_tree().paused = true
	
	$OptionsMenu/MarginContainer/VBoxContainer/BackButton.grab_focus()
	
func open_how_to_play_menu():
	current_state = UIState.MAIN_MENU
	$MainMenu.hide()
	$OptionsMenu.hide()
	$HowToPlayMenu.show()
	get_tree().paused = true
	
	$HowToPlayMenu/MarginContainer/VBoxContainer/BackButton.grab_focus()
	
func start_game():
	current_state = UIState.GAMEPLAY
	$MainMenu.hide()
	$OptionsMenu.hide()
	$HowToPlayMenu.hide()
	get_tree().paused = false
	EventBus.world.game_started.emit()
	get_tree().change_scene_to_file("res://main/main.tscn")
	
func get_current_state() -> UIState:
	return current_state
	
func is_game_running() -> bool:
	return (
		not $MainMenu.visible 
		and not $OptionsMenu.visible
		and not $HowToPlayMenu.visible
	)
	
