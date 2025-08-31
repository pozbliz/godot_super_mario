extends Node


var player_sounds = {
	"player_hit": "res://assets/sound/player/player_hit.wav",
	"player_died": "res://assets/sound/player/player_died.wav",
}

var enemy_sounds = {
	"enemy_hit": "res://assets/sound/enemy/enemy_hit.wav",
}

var world_sounds = {
	"mushroom_picked_up": "res://assets/sound/world/mushroom_picked_up.wav",
	"coin_picked_up": "res://assets/sound/world/coin_picked_up.wav",
	"level_finished": "res://assets/sound/world/level_finished.wav",
}

var music = {
	1: "res://assets/sound/music/Hillbilly Swing.mp3",
}


func _ready() -> void:
	### PLAYER ###
	EventBus.player_hit.connect(_on_player_hit)
	EventBus.player_died.connect(_on_player_died)
	
	### ENEMY ###
	EventBus.enemy_hit.connect(_on_enemy_hit)
	
	### WORLD ###
	EventBus.coin_picked_up.connect(_on_coin_picked_up)
	EventBus.mushroom_picked_up.connect(_on_mushroom_picked_up)
	EventBus.level_finished.connect(_on_level_finished)
	
	### MUSIC ###
	EventBus.level_started.connect(_on_level_started)
	

### PLAYER ###
func _on_player_hit():
	AudioManager.play(player_sounds["player_hit"])

func _on_player_died():
	AudioManager.play(player_sounds["player_died"])
	
	
### ENEMIES ###
func _on_enemy_hit():
	AudioManager.play(enemy_sounds["enemy_hit"])


### WORLD ###
func _on_coin_picked_up():
	AudioManager.play(world_sounds["coin_picked_up"])
	
func _on_mushroom_picked_up():
	AudioManager.play(world_sounds["mushroom_picked_up"])
	
func _on_level_finished():
	AudioManager.play(world_sounds["level_finished"])
	

### MUSIC ###
func _on_level_started(level: int):
	AudioManager.play(music[level])
