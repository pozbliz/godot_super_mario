extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Player):
	EventBus.world.level_finished.emit()
