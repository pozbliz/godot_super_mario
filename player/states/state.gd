class_name State
extends Node


var player: Player
var state_machine: StateMachine


func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(
		player != null, 
		"State must be used only in player scene. It needs owner to be Player node."
	)

func enter():
	pass

func exit():
	pass
	
func physics_update(delta: float):
	pass

func handle_input(event):
	pass
