class_name PipeState
extends State


var initial_position: Vector2
var timer: float = 0.0
var enter_duration: float = 1.0


func enter():
	EventBus.pipe_entered.emit()
	player.velocity = Vector2.ZERO
	player.play_animation("pipe")
	initial_position = player.global_position
	timer = 0.0
	
func physics_update(delta: float) -> void:
	timer += delta
	if timer >= enter_duration:
		if player.current_pipe and player.current_pipe.linked_pipe:
			var destination_pipe = player.current_pipe.linked_pipe
			var exit_pos = destination_pipe.exit_point.global_position

			player.global_position = exit_pos
			await player.play_animation("pipe", true)
			state_machine.change_state(player.states.idle)
