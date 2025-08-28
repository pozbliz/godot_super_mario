class_name FallingState
extends State


var fast_fall_acc: float = 2000.0


func enter():
	player.play_animation("fall")

func physics_update(delta: float) -> void:
	player.input_direction_x = Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * player.input_direction_x
	player.velocity.y += player.gravity * delta
	
	if Input.is_action_pressed("duck"):
		player.velocity.y += fast_fall_acc * delta
	
	if player.input_direction_x != 0:
		player.facing_direction_x = player.input_direction_x
	player.sprite.flip_h = player.facing_direction_x < 0
	
	player.move_and_slide()

	if player.is_on_floor():
		if is_equal_approx(player.input_direction_x, 0.0):
			state_machine.change_state(player.states.idle)
		else:
			state_machine.change_state(player.states.run)
			
func bounce():
	player.velocity.y = player.jump_velocity * 0.5
	state_machine.change_state(player.states.jump)
