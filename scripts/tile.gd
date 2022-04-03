class_name Tile
extends Area2D

# Emitted when transitioning to a new state.
signal transitioned(state_name, tile)

export(bool) var has_mine = false
export(int) var neighbouring_mines = 0

var coords: Vector2

var flag_texture: Texture = preload("res://tiles/flag.tres")
var unpressed_texture: Texture = preload("res://tiles/up.tres")
var pressed_texture: Texture = preload("res://tiles/down.tres")
var mine_texture: Texture = preload("res://tiles/mine.tres")

var one_texture: Texture = preload("res://tiles/one.tres")
var two_texture: Texture = preload("res://tiles/two.tres")
var three_texture: Texture = preload("res://tiles/three.tres")
var four_texture: Texture = preload("res://tiles/four.tres")
var five_texture: Texture = preload("res://tiles/five.tres")
var six_texture: Texture = preload("res://tiles/six.tres")
var seven_texture: Texture = preload("res://tiles/seven.tres")
var eight_texture: Texture = preload("res://tiles/eight.tres")
var nine_texture: Texture = preload("res://tiles/nine.tres")\

var value_map: Dictionary = {
	0: pressed_texture,
	1: one_texture,
	2: two_texture,
	3: three_texture,
	4: four_texture,
	5: five_texture,
	6: six_texture,
	7: seven_texture,
	8: eight_texture,
	9: nine_texture
}

onready var game_board: Node2D = get_parent()

func _on_Tile_transitioned(state_name: String, _tile: Tile) -> void:
	match state_name:
		"Pressed":
			$Sprite.texture = pressed_texture
		"Commited":
			$Sprite.texture = value_map[neighbouring_mines]
			if has_mine:
				$Sprite.texture = mine_texture
		"Uncommited":
			$Sprite.texture = unpressed_texture
		"Flagged":
			$Sprite.texture = flag_texture
			
func commit() -> void:
	$StateMachine.commit()
