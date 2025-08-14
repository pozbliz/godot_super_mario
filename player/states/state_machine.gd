extends Node

@export var initial_state: State

var current_state: State


func _ready():
	change_state(initial_state)

func _unhandled_input(event):
	if current_state:
		current_state.handle_input(event)

func change_state(new_state: State):
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.player = get_parent()
	current_state.state_machine = self
	current_state.enter()

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)
