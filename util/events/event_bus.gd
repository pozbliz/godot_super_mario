extends Node


var player: PlayerEvents
var enemy: EnemyEvents
var world: WorldEvents


func _ready() -> void:
	player = PlayerEvents.new()
	enemy = EnemyEvents.new()
	world = WorldEvents.new()
