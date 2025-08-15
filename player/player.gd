class_name Player
extends CharacterBody2D


@export var speed: float = 300.0
@export var jump_velocity: float = -700.0
@export var gravity: float = 1500.0
@export var acceleration: float = 0.2
@export var coyote_time: float = 0.1
@export var max_jump_hold_time: float = 0.2

var coyote_timer: float = 0.0
var input_direction_x: float
var jump_held_time: float = 0.0
var is_jumping: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var states = {
	"idle": $StateMachine/Idle,
	"run": $StateMachine/Run,
	"jump": $StateMachine/Jump,
	"fall": $StateMachine/Fall,
	"duck": $StateMachine/Duck
}


func _ready() -> void:
	state_machine.change_state(states.idle)
	
func _unhandled_input(event: InputEvent) -> void:
	if get_tree().paused:
		return
	
func _on_death():
	EventBus.player.player_died.emit()
