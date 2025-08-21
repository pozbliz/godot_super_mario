class_name Enemy
extends CharacterBody2D


signal enemy_died


func _ready() -> void:
	add_to_group("enemy")
	#if $AnimatedSprite2D:
		#$AnimatedSprite2D.play("default")

func _process(delta: float) -> void:
	pass

func die():
	if $AnimatedSprite2D:
		$AnimatedSprite2D.play("death")
		$HitboxComponent/CollisionShape2D.disabled = true
		set_deferred("monitoring", false)
		await $AnimatedSprite2D.animation_finished
		EventBus.enemy.enemy_died.emit()
	queue_free()
