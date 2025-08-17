class_name HealthComponent
extends Node


@export var MAX_HEALTH: float = 1.0

var current_health: float

func _ready() -> void:
	current_health = MAX_HEALTH

func damage(attack: Attack):
	current_health -= attack.attack_damage
	
	if current_health <= 0:
		await get_parent()._on_death()
