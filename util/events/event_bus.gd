extends Node


### PLAYER ###
signal player_hit
signal player_died
signal lives_updated(current_lives)

### ENEMY ###
signal enemy_hit

### WORLD ###
# UI Signals
signal game_paused
signal game_resumed
signal options_menu_opened
signal how_to_play_opened
signal main_menu_opened
signal back_button_pressed
signal game_over
signal score_changed(new_score: int)

# Gameplay Signals
signal powerup_picked_up(powerup: PowerUp)
signal mushroom_picked_up
signal coin_picked_up
signal level_finished
