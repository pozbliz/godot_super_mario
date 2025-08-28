# death_anim.gd
extends AnimatedSprite2D

func _ready():
	hit_flash(1)
	play("death")
	animation_finished.connect(_on_animation_finished)

func _on_animation_finished() -> void:
	queue_free()
	
func hit_flash(blinks: int) -> void:
	await get_tree().process_frame
	for i in range(blinks):
		material.set("shader_parameter/flash", true)
		await get_tree().create_timer(0.10).timeout
		material.set("shader_parameter/flash", false)
		await get_tree().create_timer(0.10).timeout
