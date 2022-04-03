class_name Tile
extends Area2D

var commited: bool = false

var flag_texture: Texture = preload("res://tiles/flag.tres")
var unpressed_texture: Texture = preload("res://tiles/up.tres")
var pressed_texture: Texture = preload("res://tiles/down.tres")

onready var game_board: Node2D = get_parent()

func _on_StateMachine_transitioned(state_name):
	match state_name:
		"Pressed", "Commited":
			$Sprite.texture = pressed_texture
		"Uncommited":
			$Sprite.texture = unpressed_texture
		"Flagged":
			$Sprite.texture = flag_texture
