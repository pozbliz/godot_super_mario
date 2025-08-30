extends HBoxContainer

var heart_full = preload("res://assets/life_icon.png")

func _ready() -> void:
	hide()
	EventBus.lives_updated.connect(update_health)

func update_health(value):
	show()
	for i in get_child_count():
		get_child(i).visible = value > i
	
