class_name HealthComponent
extends Node


@export var max_health: float = 1.0

var current_health: float

func _ready() -> void:
	current_health = max_health

func damage(attack: Attack):
	current_health -= attack.attack_damage
	
	if get_parent() is Player:
		get_parent().take_damage()
	
	if current_health <= 0:
		await get_parent().die()
