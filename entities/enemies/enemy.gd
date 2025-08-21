class_name Enemy
extends CharacterBody2D


signal enemy_died

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D



func _ready() -> void:
	add_to_group("enemy")
	#if sprite:
		#sprite.play("default")

func _process(delta: float) -> void:
	pass

func die():
	print("enemy dying")
	sprite.play("death")
	$HitboxComponent/CollisionShape2D.disabled = true
	set_deferred("monitoring", false)
	await sprite.animation_finished
	EventBus.enemy.enemy_died.emit()
	queue_free()
