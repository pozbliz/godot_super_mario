class_name JumpingState
extends State


const GRAVITY: float = 1500


func handle_input(_event: InputEvent) -> void:
	if get_tree().paused:
		return
		
	player.input_direction_x = Input.get_axis("move_left", "move_right")
	
func enter():
	player.velocity.y = player.jump_velocity
	player.jump_held_time = 0.0
	player.is_jumping = true
	player.play_animation("jump")
	EventBus.jump_pressed.emit()
	
func physics_update(delta: float) -> void:
	player.velocity.x = player.speed * player.input_direction_x
	player.velocity.y += player.gravity * delta
	
	if player.is_jumping:
		player.jump_held_time += delta
		if not Input.is_action_pressed("jump") and player.velocity.y < 0:
			player.velocity.y *= 0.5
			player.is_jumping = false
		elif player.jump_held_time >= player.max_jump_hold_time:
			player.is_jumping = false
			
	if player.input_direction_x != 0:
		player.facing_direction_x = player.input_direction_x
	player.sprite.flip_h = player.facing_direction_x < 0
	
	player.move_and_slide()

	if not player.is_on_floor() and player.velocity.y >= 0:
		state_machine.change_state(player.states.fall)
