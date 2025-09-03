class_name Pipe
extends StaticBody2D


@export var linked_pipe: Pipe

var exit_point: Marker2D

@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	area_2d.body_entered.connect(_on_body_entered)
	area_2d.body_exited.connect(_on_body_exited)
	exit_point = $ExitPoint
	
func _on_body_entered(body: Player):
	body.current_pipe = self
	
func _on_body_exited(body: Player):
	body.current_pipe = null
