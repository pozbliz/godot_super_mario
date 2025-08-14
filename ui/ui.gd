extends CanvasLayer


signal game_started

enum UIState { MAIN_MENU, PAUSE_MENU, OPTIONS_MENU, GAMEPLAY, GAME_FINISHED }

var current_state: UIState = UIState.MAIN_MENU
var previous_state: UIState = current_state


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$MainMenu/MarginContainer/VBoxContainer/StartGameButton.pressed.connect(_on_start_game_button_pressed)
	$MainMenu/MarginContainer/VBoxContainer/HowToPlayButton.pressed.connect(_on_how_to_play_button_pressed)
	$MainMenu/MarginContainer/VBoxContainer/OptionsButton.pressed.connect(_on_options_button_pressed)
	$MainMenu/MarginContainer/VBoxContainer/ExitGameButton.pressed.connect(_on_exit_game_button_pressed)
	
	$PauseMenu/MarginContainer/VBoxContainer/ResumeGameButton.pressed.connect(_on_resume_game_button_pressed)
	$PauseMenu/MarginContainer/VBoxContainer/NewGameButton.pressed.connect(_on_start_game_button_pressed)
	$PauseMenu/MarginContainer/VBoxContainer/OptionsButton.pressed.connect(_on_options_button_pressed)
	$PauseMenu/MarginContainer/VBoxContainer/ExitGameButton.pressed.connect(_on_exit_game_button_pressed)
	
	$HowToPlayMenu/MarginContainer/VBoxContainer/BackButton.pressed.connect(_on_back_button_pressed)
	$OptionsMenu/MarginContainer/VBoxContainer/BackButton.pressed.connect(_on_back_button_pressed)
	
	$GameFinishedScreen/MarginContainer/VBoxContainer/ReturnMainMenuButton.pressed.connect(_on_return_main_menu_button_pressed)
	
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_menu"):
		match current_state:
			UIState.GAMEPLAY:
				open_pause_menu()
			UIState.PAUSE_MENU:
				resume_game()
	
func _gui_input(event):
	if event.is_action_pressed("ui_up"):
		event.consume()
	elif event.is_action_pressed("ui_down"):
		event.consume()
		
func _on_start_game_button_pressed():
	start_game()
	
func _on_how_to_play_button_pressed():
	open_how_to_play_menu()
	
func _on_back_button_pressed():
	if previous_state == UIState.MAIN_MENU:
		open_main_menu()
	else:
		open_pause_menu()
	
func _on_resume_game_button_pressed():
	resume_game()
	
func _on_options_button_pressed():
	open_options_menu()
	
func _on_exit_game_button_pressed():
	get_tree().quit()
	
func _on_return_main_menu_button_pressed():
	open_main_menu()
	
func open_main_menu():
	current_state = UIState.MAIN_MENU
	$MainMenu.show()
	$PauseMenu.hide()
	$OptionsMenu.hide()
	$HUD.hide()
	$HowToPlayMenu.hide()
	$GameFinishedScreen.hide()
	get_tree().paused = true
	
	$MainMenu/MarginContainer/VBoxContainer/StartGameButton.grab_focus()

func open_pause_menu():
	previous_state = current_state
	current_state = UIState.PAUSE_MENU
	$MainMenu.hide()
	$PauseMenu.show()
	$OptionsMenu.hide()
	$HUD.show()
	get_tree().paused = true
	
	$PauseMenu/MarginContainer/VBoxContainer/ResumeGameButton.grab_focus()

func open_options_menu():
	current_state = UIState.OPTIONS_MENU
	$MainMenu.hide()
	$PauseMenu.hide()
	$OptionsMenu.show()
	$HUD.hide()
	$GameFinishedScreen.hide()
	get_tree().paused = true
	
	$OptionsMenu/MarginContainer/VBoxContainer/BackButton.grab_focus()
	
func open_how_to_play_menu():
	current_state = UIState.MAIN_MENU
	$MainMenu.hide()
	$PauseMenu.hide()
	$OptionsMenu.hide()
	$HUD.hide()
	$HowToPlayMenu.show()
	$GameFinishedScreen.hide()
	get_tree().paused = true
	
	$HowToPlayMenu/MarginContainer/VBoxContainer/BackButton.grab_focus()
	
func show_game_won_screen():
	current_state = UIState.GAME_FINISHED
	$MainMenu.hide()
	$PauseMenu.hide()
	$OptionsMenu.hide()
	$HUD.hide()
	$HowToPlayMenu.hide()
	$GameFinishedScreen.show()
	get_tree().paused = true
	
	$GameFinishedScreen/MarginContainer/VBoxContainer/ReturnMainMenuButton.grab_focus()
	
func start_game():
	current_state = UIState.GAMEPLAY
	$MainMenu.hide()
	$PauseMenu.hide()
	$OptionsMenu.hide()
	$HUD.show()
	get_tree().paused = false
	game_started.emit()
	
func resume_game():
	current_state = UIState.GAMEPLAY
	$MainMenu.hide()
	$PauseMenu.hide()
	$OptionsMenu.hide()
	$HUD.show()
	get_tree().paused = false
	
func get_current_state() -> UIState:
	return current_state
	
func is_game_running() -> bool:
	return (
		$HUD.visible 
		and not $MainMenu.visible 
		and not $PauseMenu.visible 
		and not $OptionsMenu.visible
		and not $GameFinishedScreen.visible
	)
	
