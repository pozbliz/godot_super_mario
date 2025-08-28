class_name HurtboxComponent
extends Area2D


@export var health_component: HealthComponent


func _ready():
	area_entered.connect(_on_hurtbox_component_area_entered)
	
func _on_hurtbox_component_area_entered(area: AttackHitbox) -> void:
	var area_owner = area.get_parent()
	var self_owner = get_parent()
	
	for group in area_owner.get_groups():
		if self_owner.is_in_group(group):
			return
			
		health_component.damage(area.get_attack())
