# pause_menu.gd
extends Control

signal level_finished
signal main_menu_opened

@onready var resume_game_button: Button = $MarginContainer/VBoxContainer/ResumeGameButton
@onready var how_to_play_button: Button = $MarginContainer/VBoxContainer/HowToPlayButton
@onready var options_button: Button = $MarginContainer/VBoxContainer/OptionsButton
@onready var main_menu_button: Button = $MarginContainer/VBoxContainer/MainMenuButton


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	hide()
	
	EventBus.world.pause_requested.connect(open)
	EventBus.world.how_to_play_opened.connect(close)
	EventBus.world.options_menu_opened.connect(close)
	EventBus.world.back_button_pressed.connect(open)

	resume_game_button.pressed.connect(_on_resume_game_button_pressed)
	how_to_play_button.pressed.connect(_on_how_to_play_button_pressed)
	options_button.pressed.connect(_on_options_button_pressed)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)

func open():
	show()
	resume_game_button.grab_focus()

func close():
	hide()
	
func _on_resume_game_button_pressed():
	EventBus.world.game_resumed.emit()
	close()
	
func _on_how_to_play_button_pressed():
	EventBus.world.how_to_play_opened.emit()
	close()
	
func _on_options_button_pressed():
	EventBus.world.options_menu_opened.emit()
	close()
	
func _on_main_menu_button_pressed():
	EventBus.world.main_menu_opened.emit()
	close()
