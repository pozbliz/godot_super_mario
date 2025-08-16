class_name AttackHitbox
extends Area2D


@export var contact_damage: int = 1


func get_attack() -> Attack:
	var attack := Attack.new()
	attack.attack_damage = contact_damage
	return attack
