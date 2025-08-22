class_name Enemy
extends CharacterBody2D


signal enemy_died

@export var speed : float = 30.0
@export var gravity : float = 1500.0
@export var patrol_distance : float = 100.0
@export var death_scene: PackedScene
@export var death_spritesheet: Texture2D

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
	velocity.x = direction.x * speed
	velocity.y += gravity * delta
	
	move_and_slide()
	
	update_physics(delta)
	
func setup() -> void:
	pass
	
func update_physics(delta : float) -> void:
	pass

func die():
	# Release enemy immediately and instantiate death animation scene instead
	set_deferred("monitoring", false)
	EventBus.enemy.enemy_died.emit()
	queue_free()
	
	var death_anim = death_scene.instantiate()
	death_anim.global_position = global_position
	get_parent().add_child(death_anim)
	death_anim.setup(death_spritesheet, Vector2(32,32), 6, 12)
