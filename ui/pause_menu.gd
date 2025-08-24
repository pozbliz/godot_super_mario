# pause_menu.gd
extends Control

signal game_resumed
signal options_menu_opened
signal returned_to_main_menu

@onready var resume_game_button: Button = $MarginContainer/VBoxContainer/ResumeGameButton
@onready var options_button: Button = $MarginContainer/VBoxContainer/OptionsButton
@onready var main_menu_opened_button: Button = $MarginContainer/VBoxContainer/MainMenuOpenedButton


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	resume_game_button.pressed.connect(_on_resume_game_button_pressed)
	options_button.pressed.connect(_on_options_button_pressed)
	main_menu_opened_button.pressed.connect(_on_main_menu_opened_button_pressed)

func open():
	show()
	resume_game_button.grab_focus()

func close():
	hide()
	
func _on_resume_game_button_pressed():
	EventBus.world.game_resumed.emit()
	
func _on_options_button_pressed():
	EventBus.world.options_menu_opened.emit()
	
func _on_main_menu_opened_button_pressed():
	EventBus.world.main_menu_opened.emit()
