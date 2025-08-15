extends State


func enter():
	player.velocity.x = 0.0
	#player.sprite.play("duck")
	pass
	
func physics_update(delta: float) -> void:
	player.direction.x = Input.get_axis("move_left", "move_right")
	
	if not player.is_on_floor():
		state_machine.change_state(player.states.fall)
	elif Input.is_action_just_pressed("jump"):
		state_machine.change_state(player.states.jump)
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.change_state(player.states.run)
