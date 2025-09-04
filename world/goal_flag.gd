extends Area2D


var triggered_flag: bool

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	triggered_flag = false
	
func _on_body_entered(body: Player):
	if triggered_flag:
		return
		
	triggered_flag = true
	animation_player.play("level_finished")
	await animation_player.animation_finished
	EventBus.level_finished.emit()
	
