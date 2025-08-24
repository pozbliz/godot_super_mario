# pause_menu.gd
extends Control

signal main_menu_opened

@onready var main_menu_button: Button = $MarginContainer/VBoxContainer/MainMenuButton


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	hide()
	
	EventBus.world.level_finished.connect(open)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)

func open():
	show()
	main_menu_button.grab_focus()

func close():
	hide()
	
func _on_main_menu_button_pressed():
	EventBus.world.main_menu_opened.emit()
