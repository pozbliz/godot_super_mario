extends Node


var player = {
	"player_hit": "res://assets/sound/player/player_hit.wav",
	"player_died": "res://assets/sound/player/player_died.wav",
}

var enemy = {
	"enemy_hit": "res://assets/sound/enemy/enemy_hit.wav",
}

var world = {
	"mushroom_picked_up": "res://assets/sound/world/mushroom_picked_up.wav",
	"coin_picked_up": "res://assets/sound/world/coin_picked_up.wav",
	"pipe_entered": "mushroom_picked_up.wav", # TODO: create pipe sound
	"level_finished": "res://assets/sound/world/level_finished.wav",
}

var music = {
	1: "res://assets/sound/music/Hillbilly Swing.mp3",
}

var menu = {
	"select": "res://assets/sound/menu/menu_select.wav"
}


func _ready() -> void:
	### PLAYER ###
	EventBus.player_hit.connect(_on_player_hit)
	EventBus.player_died.connect(_on_player_died)
	EventBus.player_respawned.connect(_on_player_respawned)
	
	### ENEMY ###
	EventBus.enemy_hit.connect(_on_enemy_hit)
	
	### WORLD ###
	EventBus.coin_picked_up.connect(_on_coin_picked_up)
	EventBus.mushroom_picked_up.connect(_on_mushroom_picked_up)
	EventBus.pipe_entered.connect(_on_pipe_entered)
	EventBus.level_finished.connect(_on_level_finished)
	
	### MUSIC ###
	EventBus.level_started.connect(_on_level_started)
	
	### MENU ###
	EventBus.menu_selected.connect(_on_menu_selected)
	

### PLAYER ###
func _on_player_hit():
	AudioManager.play(player["player_hit"])

func _on_player_died():
	AudioManager.stop_music()
	AudioManager.play(player["player_died"])
	
func _on_player_respawned(level: int):
	AudioManager.play_music(music[level])
	
	
### ENEMIES ###
func _on_enemy_hit():
	AudioManager.play(enemy["enemy_hit"])


### WORLD ###
func _on_coin_picked_up():
	AudioManager.play(world["coin_picked_up"])
	
func _on_mushroom_picked_up():
	AudioManager.play(world["mushroom_picked_up"])
	
func _on_pipe_entered():
	AudioManager.play(world["pipe_entered"])
	
func _on_level_finished():
	AudioManager.stop_music()
	AudioManager.play(world["level_finished"])
	

### MUSIC ###
func _on_level_started(level: int):
	AudioManager.play_music(music[level])
	

### MENU ###
func _on_menu_selected():
	AudioManager.play(menu["select"])
