extends State


const GRAVITY: float = 1500


func handle_input(_event: InputEvent) -> void:
	if get_tree().paused:
		return
		
func enter():
	player.velocity.y = player.JUMP_VELOCITY
	#player.play_animation("jump")
