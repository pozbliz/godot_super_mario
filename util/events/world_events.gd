class_name WorldEvents
extends Node

# UI Signals
signal game_started
signal pause_requested
signal game_resumed
signal options_menu_opened
signal main_menu_opened
signal back_button_pressed
signal level_finished
signal game_over
signal score_changed(new_score: int)

# Gameplay Signals
signal powerup_picked_up(powerup: PowerUp)
signal mushroom_picked_up
signal coin_picked_up
