class_name StateMachine
extends Node

var current_state: State

@onready var initial_state: State = $Idle


func _ready():
	await owner.ready
	change_state(initial_state)

func _unhandled_input(event):
	if current_state:
		current_state.handle_input(event)

func change_state(new_state: State):
	if current_state:
		current_state.exit()
		print("leaving: ", current_state)
	current_state = new_state
	current_state.player = get_parent()
	current_state.state_machine = self
	current_state.enter()
	print("entering: ", current_state)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)
