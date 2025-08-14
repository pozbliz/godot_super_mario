extends Control


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$MarginContainer/MessageTimer.timeout.connect(_on_message_timer_timeout)
	$MarginContainer/Message.hide()
	
func show_message(text):
	$MarginContainer/Message.text = text
	$MarginContainer/Message.show()
	$MarginContainer/MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	await $MarginContainer/MessageTimer.timeout
	
func update_score(score):
	$HBoxContainer/ScoreLabel.text = str(score)
	
func _on_message_timer_timeout():
	$MarginContainer/Message.hide()
