class_name Enemy
extends CharacterBody2D


signal enemy_died

@export var enemy_data: EnemyData
@export var death_scene: PackedScene

var direction: Vector2 = Vector2.RIGHT
var behavior: Node = null
var attack_damage: int = 1
var max_health: int = 1

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var starting_position: Vector2 = global_position
@onready var floor_ray: RayCast2D = $FloorRay
@onready var wall_ray: RayCast2D = $WallRay


func _ready() -> void:
	add_to_group("enemy")
	sprite.play("default")
	
	if enemy_data:
		max_health = enemy_data.max_health
		attack_damage = enemy_data.attack_power
		if enemy_data.behavior_script:
			behavior = enemy_data.behavior_script.new()
			add_child(behavior)
			behavior.owner = self
			if behavior.has_method("init"):
				behavior.init(self)
	
	setup()

func _physics_process(delta: float) -> void:
	if abs(global_position.x - starting_position.x) > enemy_data.patrol_distance:
		direction *= -1
	velocity.x = direction.x * enemy_data.speed
	velocity.y += enemy_data.gravity * delta
	
	move_and_slide()
	
	if (not floor_ray.is_colliding() or wall_ray.is_colliding()) and is_on_floor():
		direction.x = -direction.x
		scale.x = -scale.x
	
	update_physics(delta)
	
func setup() -> void:
	pass
	
func update_physics(_delta: float) -> void:
	pass

func hit_flash(blinks: int):
	for i in range(0, blinks):
		sprite.material.set("shader_parameter/flash", true)
		await get_tree().create_timer(0.10).timeout
		sprite.material.set("shader_parameter/flash", false)
		await get_tree().create_timer(0.10).timeout

func die():
	# Release enemy immediately and instantiate death animation scene instead
	$HitboxComponent.monitoring = false
	$HitboxComponent/CollisionShape2D.disabled = true
	EventBus.enemy_hit.emit()
	
	call_deferred("queue_free")
	
	var death_anim = death_scene.instantiate()
	death_anim.position = get_parent().to_local(global_position)
	get_parent().add_child(death_anim)
