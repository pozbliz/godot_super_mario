class_name Player
extends CharacterBody2D


@export var speed: float = 300.0
@export var jump_velocity: float = -700.0
@export var gravity: float = 1500.0
@export var acceleration: float = 0.2
@export var coyote_time: float = 0.1
@export var max_jump_hold_time: float = 0.2
@export var max_health: float = 1.0

var attack_damage: int = 1
var coyote_timer: float = 0.0
var input_direction_x: float
var facing_direction_x: float = 1.0
var jump_held_time: float = 0.0
var is_jumping: bool = false
var animation_map = {
	"idle": ["small_idle", "big_idle"],
	"run":  ["small_run", "big_run"],
	"jump": ["small_jump", "big_jump"],
	"fall": ["small_fall", "big_fall"],
	"duck": ["small_duck", "big_duck"]
}

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var world_collider: CollisionShape2D = $CollisionShape2D
@onready var state_machine = $StateMachine
@onready var states = {
	"idle": $StateMachine/Idle,
	"run": $StateMachine/Run,
	"jump": $StateMachine/Jump,
	"fall": $StateMachine/Fall,
	"duck": $StateMachine/Duck
}
@onready var growth_stage: int = 0
@onready var viewport_size: Vector2 = get_viewport_rect().size


func _ready() -> void:
	state_machine.change_state(states.idle)
	EventBus.world.mushroom_picked_up.connect(grow)
	add_to_group("player")
	
func _unhandled_input(_event: InputEvent) -> void:
	if get_tree().paused:
		return
		
func _physics_process(delta: float) -> void:
	if global_position.y > viewport_size.y:
		die()
		
func grow() -> void:
	growth_stage += 1
	clamp(growth_stage, 0, 1)
	$HealthComponent.max_health = 2
	$HealthComponent.current_health = 2
	animation_player.play("grow")
		
func shrink() -> void:
	growth_stage -= 1
	clamp(growth_stage, 0, 1)
	animation_player.play("shrink")
		
func play_animation(action: String) -> void:
	var animation = animation_map[action][growth_stage]
	sprite.play(animation)
	
func take_damage() -> void:
	if growth_stage >= 1:
		shrink()
	else:
		die()
	
func die() -> void:
	EventBus.player.player_died.emit()
	# TODO: add death animation
