extends State


func enter():
	player.play_animation("fall")

func physics_update(delta: float) -> void:
	player.input_direction_x = Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * player.input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if player.is_on_floor():
		if is_equal_approx(player.input_direction_x, 0.0):
			state_machine.change_state(player.states.idle)
		else:
			state_machine.change_state(player.states.run)
