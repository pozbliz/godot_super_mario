extends State


func enter():
	#player.sprite.play("run")
	pass

func physics_update(delta: float) -> void:
	player.input_direction_x = Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * player.input_direction_x
	player.velocity.y += player.gravity * delta
		
	player.move_and_slide()
	
	if player.is_on_floor():
		player.coyote_timer = player.coyote_time
	else:
		player.coyote_timer -= delta

	if player.coyote_timer <= 0 and player.velocity.y > 0:
		state_machine.change_state(player.states.fall)
	elif Input.is_action_just_pressed("jump") and player.coyote_timer > 0:
		state_machine.change_state(player.states.jump)
	elif is_equal_approx(player.input_direction_x, 0.0):
		state_machine.change_state(player.states.idle)
	elif Input.is_action_just_pressed("duck"):
		state_machine.change_state(player.states.duck)
	
