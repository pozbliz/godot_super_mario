extends State


func enter():
	player.velocity.x = 0.0
	player.play_animation("duck")
	
func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta
	if not Input.is_action_pressed("duck"):
		state_machine.change_state(player.states.idle)
	elif not player.is_on_floor():
		state_machine.change_state(player.states.fall)
	elif Input.is_action_just_pressed("jump"):
		state_machine.change_state(player.states.jump)
