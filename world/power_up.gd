class_name PowerUp
extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(_delta: float) -> void:
	pass
	
func _on_body_entered(body: CharacterBody2D) -> void:
	print("powerup picked up")
	if not body is Player:
		return
	
	_on_powerup_pickup()
	EventBus.world.powerup_picked_up.emit(self)
	queue_free()
	
func _on_powerup_pickup():
	pass
