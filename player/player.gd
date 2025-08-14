extends CharacterBody2D


var direction: Vector2 = Vector2.ZERO
var friction = 0.1
var acceleration = 0.25


const SPEED: float = 200.0
const JUMP_VELOCITY: float = -600.0


func _ready() -> void:
	hide()
	
func _unhandled_input(_event: InputEvent) -> void:
	if get_tree().paused:
		return
	if Input.is_action_just_pressed("move_left"):
		direction = Vector2.LEFT
	if Input.is_action_just_pressed("move_right"):
		direction = Vector2.RIGHT
	if Input.is_action_just_pressed("move_down"):
		duck()
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

	move_and_slide()
	
func duck():
	pass
