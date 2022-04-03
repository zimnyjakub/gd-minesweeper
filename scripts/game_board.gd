extends Node2D

export(int) var size: int = 8
var tile_resource: PackedScene = preload("res://tile.tscn")

var tile_size_x: int = 16
var tile_size_y: int = 16

var dragging: bool = false;

func _ready():
	var tile = tile_resource.instance()
	tile_size_x = tile.get_node("Sprite").texture.get_width()  * tile.scale.x
	tile_size_y = tile.get_node("Sprite").texture.get_height() * tile.scale.y
	tile.queue_free()
	generate_new_board()
	
	
func generate_new_board() -> void:
	for x in range(0, size):
		for y in range(0, size):
			var tile = tile_resource.instance()
			tile.position.x = x + tile_size_x * x
			tile.position.y = y + tile_size_y * y
			add_child(tile)
