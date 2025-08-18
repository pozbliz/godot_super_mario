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

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine = $StateMachine
@onready var states = {
	"idle": $StateMachine/Idle,
	"run": $StateMachine/Run,
	"jump": $StateMachine/Jump,
	"fall": $StateMachine/Fall,
	"duck": $StateMachine/Duck
}
@onready var growth_stage: int = 0


func _ready() -> void:
	state_machine.change_state(states.idle)
	EventBus.world.mushroom_picked_up.connect(grow)
	
func _unhandled_input(_event: InputEvent) -> void:
	if get_tree().paused:
		return
		
func grow():
	if growth_stage == 0:
		growth_stage += 1
		
func play_animation(action: String):
	var animation = "%s_stage%d" % [action, growth_stage]
	animation_player.play(animation)
	
func _on_death():
	EventBus.player.player_died.emit()
