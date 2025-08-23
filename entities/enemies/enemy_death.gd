# death_anim.gd
extends AnimatedSprite2D

func _ready():
	play("death")
	animation_finished.connect(_on_animation_finished)

func _on_animation_finished() -> void:
	queue_free()
