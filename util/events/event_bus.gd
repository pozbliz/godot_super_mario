extends Node


### PLAYER ###
signal player_hit
signal player_died
signal player_respawned(level: int)
signal lives_updated(current_lives)
signal jump_pressed

### ENEMY ###
signal enemy_hit
signal enemy_died(score: int)

### WORLD ###
# UI Signals
signal game_paused
signal game_resumed
signal level_started(level: int)
signal options_menu_opened
signal how_to_play_opened
signal main_menu_opened
signal back_button_pressed
signal game_over
signal score_changed(new_score: int)
signal timer_updated(time_left)
signal menu_selected

# Gameplay Signals
signal powerup_picked_up(powerup: PowerUp)
signal mushroom_picked_up
signal pipe_entered
signal coin_picked_up
signal level_finished
signal level_timeout
