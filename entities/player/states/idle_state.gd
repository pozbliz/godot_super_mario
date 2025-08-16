extends State


func enter():
	player.velocity.x = 0.0
	#player.sprite.play("idle")

func physics_update(_delta: float) -> void:
	player.velocity.y += player.gravity * _delta
	player.move_and_slide()

	if not player.is_on_floor():
		state_machine.change_state(player.states.fall)
	elif Input.is_action_just_pressed("jump"):
		state_machine.change_state(player.states.jump)
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.change_state(player.states.run)
	elif Input.is_action_just_pressed("duck"):
		state_machine.change_state(player.states.duck)
