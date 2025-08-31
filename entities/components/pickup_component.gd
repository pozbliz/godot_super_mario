class_name PowerUp
extends Node


@export var collision_area: Area2D


func _ready() -> void:
	collision_area.body_entered.connect(_on_collision_area_body_entered)

func _on_collision_area_body_entered(body: CharacterBody2D) -> void:
	if not body is Player:
		return
	
	get_parent()._on_powerup_pickup()
	get_parent().queue_free()
