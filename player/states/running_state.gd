extends State


func enter():
	#player.play_animation("run")
	pass

func handle_input(_event: InputEvent) -> void:
	if get_tree().paused:
		return
		
	player.direction.x = Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state(player.states.jump)
		
	elif player.get_input_axis() == 0:
		state_machine.change_state(player.states.idle)
		
	elif Input.is_action_just_pressed("duck"):
		state_machine.change_state(player.states.duck)

func physics_update(delta: float) -> void:
	player.velocity.x = player.run_speed * player.direction.x.normalized()
	player.velocity.y += player.gravity * delta
	
	if not player.is_on_floor() and player.velocity.y > 0.0:
		state_machine.change_state(player.states.fall)
		
	player.move_and_slide()
	
