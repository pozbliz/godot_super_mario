class_name Enemy
extends CharacterBody2D


signal enemy_died

@export var enemy_data: EnemyData
@export var death_scene: PackedScene

var direction : Vector2 = Vector2.LEFT
var behavior: Node = null

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var starting_position : Vector2 = global_position


func _ready() -> void:
	add_to_group("enemy")
	sprite.play("default")
	
	if enemy_data:
		if enemy_data.behavior_script:
			behavior = enemy_data.behavior_script.new()
			add_child(behavior)
			behavior.owner = self
			if behavior.has_method("init"):
				behavior.init(self)
	
	setup()

func _physics_process(delta : float) -> void:
	if abs(global_position.x - starting_position.x) > enemy_data.patrol_distance:
		direction *= -1
	velocity.x = direction.x * enemy_data.speed
	velocity.y += enemy_data.gravity * delta
	sprite.flip_h = direction.x < 0
	
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
