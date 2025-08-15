extends State


const GRAVITY: float = 1500


func handle_input(_event: InputEvent) -> void:
	if get_tree().paused:
		return
		
	player.input_direction_x = Input.get_axis("move_left", "move_right")
	
func enter():
	player.velocity.y = player.jump_velocity
	#player.sprite.play("jump")
	
func physics_update(delta: float) -> void:
	player.velocity.x = player.speed * player.input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if not player.is_on_floor() and player.velocity.y >= 0:
		state_machine.change_state(player.states.fall)
