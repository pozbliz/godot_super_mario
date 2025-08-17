class_name Mushroom
extends CharacterBody2D


@export var speed: float = 100.0
@export var gravity: float = 400.0

var direction: int = 1


func _ready() -> void:
	$Area2D.body_entered.connect(_on_player_entered)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	velocity.x = direction * speed
	move_and_slide()

	if is_on_wall():
		direction *= -1

func _on_player_entered(body: CharacterBody2D) -> void:
	if not body is Player:
		return

	_on_powerup_pickup()
	EventBus.world.powerup_picked_up.emit(self)
	queue_free()
	
func _on_powerup_pickup():
	EventBus.world.mushroom_picked_up.emit()
	print("mushroom picked up")
