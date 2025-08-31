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
var is_dead: bool = false
var invincibility_timer: float = 1.0
var is_invincible: bool = false
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
	EventBus.mushroom_picked_up.connect(grow)
	EventBus.level_finished.connect(_on_level_finished)
	add_to_group("player")
	$HitboxComponent.area_entered.connect(bounce)
	
func _unhandled_input(_event: InputEvent) -> void:
	if get_tree().paused:
		return
		
func _physics_process(delta: float) -> void:
	if not is_dead and global_position.y > viewport_size.y:
		die()
		
func grow() -> void:
	if growth_stage == 1:
		return
		
	growth_stage += 1
	$HealthComponent.max_health = 2
	$HealthComponent.current_health = 2
	animation_player.play("grow")
		
func shrink() -> void:
	growth_stage -= 1
	clamp(growth_stage, 0, 1)
	animation_player.play("shrink")
	
func bounce(area: HurtboxComponent) -> void:
	if area.get_parent() is Enemy and state_machine.get_current_state() is FallingState:
		state_machine.current_state.bounce()
		
func play_animation(action: String) -> void:
	var animation = animation_map[action][growth_stage]
	sprite.play(animation)
	
func take_damage() -> void:
	if is_invincible:
		return
		
	if growth_stage >= 1:
		shrink()
	else:
		die()
		
	is_invincible = true
	var timer = get_tree().create_timer(invincibility_timer)
	hit_flash(5)
	timer.timeout.connect(_end_invincibility)
	
func _end_invincibility() -> void:
	is_invincible = false
	
func hit_flash(blinks: int):
	for i in range(0, blinks):
		sprite.material.set("shader_parameter/flash", true)
		await get_tree().create_timer(0.10).timeout
		sprite.material.set("shader_parameter/flash", false)
		await get_tree().create_timer(0.10).timeout
	
func die() -> void:
	if is_dead:
		return
		
	is_dead = true
	
	state_machine.set_process(false)
	state_machine.set_physics_process(false)
	
	sprite.play("death")
	EventBus.player_died.emit()
	
func respawn():
	is_dead = false
	is_invincible = false
	growth_stage = 0
	
func _on_level_finished():
	pass
	# TODO: play level finished animation
