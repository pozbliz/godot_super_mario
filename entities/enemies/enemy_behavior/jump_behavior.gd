extends Node

var enemy: Enemy
var timer: float = 0.0
var jump_velocity : float = -500.0

func init(e: Enemy) -> void:
    enemy = e

func _physics_process(delta: float) -> void:
    var cooldown : float = randf_range(2.0, 4.0)
    timer -= delta
    if timer <= 0:
        jump()
        timer = cooldown
    
func jump() -> void:
    enemy.velocity.y = jump_velocity
