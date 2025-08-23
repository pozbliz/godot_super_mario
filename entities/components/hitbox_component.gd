class_name AttackHitbox
extends Area2D


var contact_damage: int = 1


func _ready() -> void:
	if get_parent().contact_damage:
		contact_damage = get_parent().contact_damage


func attack() -> Attack:
	var attack := Attack.new()
	attack.attack_damage = contact_damage
	return attack
