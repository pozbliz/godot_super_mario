extends Area2D


var triggered_flag: bool


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	triggered_flag = false
	
func _on_body_entered(body: Player):
	if triggered_flag:
		return
		
	triggered_flag = true
	EventBus.level_finished.emit()
	
