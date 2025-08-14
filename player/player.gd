extends CharacterBody2D


@export var speed: float = 300.0
@export var jump_velocity: float = -500.0
@export var gravity: float = 1500.0
@export var friction: float = 0.20
@export var acceleration: float = 0.20

var direction: Vector2 = Vector2.ZERO

@onready var state_machine = $StateMachine
@onready var states = {
	"idle": $StateMachine/Idle,
	"run": $StateMachine/Jump,
	"jump": $StateMachine/Fall,
	"fall": $StateMachine/Run,
	"duck": $StateMachine/Duck
}


func _ready() -> void:
	state_machine.change_state(states.idle)
	
