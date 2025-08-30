extends Node

var num_players = 8
var bus = "master"

var available = []  # The available players.
var queue = []  # The queue of sounds to play.


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_players:
		var player = AudioStreamPlayer.new()
		add_child(player)
		available.append(player)
		player.finished.connect(_on_stream_finished.bind(player))
		player.bus = bus
		
func _on_stream_finished(stream):
	available.append(stream)
	
func play(
		sound_path: String, 
		pitch: float = 1.0, 
		volume_db: float = 0.0,  
		bus: String = "master"
	):
	queue.append({ 
		"path": sound_path,
		"pitch": pitch,
		"volume": volume_db,
		"bus": bus
	})
	
func _process(_delta):
	if not queue.is_empty() and not available.is_empty():
		var sound_data = queue.pop_front()
		var player = available.pop_front()
		
		# Load and assign stream
		player.stream = load(sound_data.path)
		if player.stream == null:
			push_warning("AudioManager: Could not load sound " + str(sound_data.path))
			return
		
		# Apply properties
		player.pitch_scale = sound_data.pitch
		player.volume_db = sound_data.volume
		player.bus = sound_data.bus
		
		player.play()
