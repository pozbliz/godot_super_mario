class_name Enemy
extends CharacterBody2D


signal enemy_died

@export var speed : float = 30.0
@export var patrol_distance : float = 100.0

var direction : Vector2 = Vector2.LEFT

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var starting_position : Vector2 = global_position


func _ready() -> void:
	add_to_group("enemy")
	#if sprite:
		#sprite.play("default")
	setup()

func _physics_process(delta : float) -> void:
	if abs(global_position.x - starting_position.x) > patrol_distance:
		direction *= -1
	velocity = direction * speed
	global_position += velocity * delta
	
	update_physics(delta)
	
func setup() -> void:
	pass
	
func update_physics(delta : float) -> void:
	pass

func die():
	print("enemy dying")
	sprite.play("death")
	$HitboxComponent/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	set_deferred("monitoring", false)
	await sprite.animation_finished
	EventBus.enemy.enemy_died.emit()
	queue_free()
