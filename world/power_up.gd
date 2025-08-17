class_name PowerUp
extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	pass
	
func _on_body_entered(body: CharacterBody2D) -> void:
	print("powerup picked up")
	if not body is Player:
		return
	
	apply_effect(body)
	EventBus.world.powerup_picked_up.emit(self)
	queue_free()
	
func apply_effect(player: Player):
	pass
