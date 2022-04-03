extends Node2D

export(int) var size: int = 8
export(int) var amount_of_mines = 3


var tile_resource: PackedScene = preload("res://tile.tscn")

var tile_size_x: int = 16
var tile_size_y: int = 16

var dragging: bool = false;

var rng = RandomNumberGenerator.new()

func _ready():
	var tile = tile_resource.instance()
	tile_size_x = tile.get_node("Sprite").texture.get_width()  * tile.scale.x
	tile_size_y = tile.get_node("Sprite").texture.get_height() * tile.scale.y
	tile.queue_free()
	generate_new_board()
	
	
func generate_new_board() -> void:
	rng.randomize()
	var mines = generate_mine_locations()
	print_debug(mines)
	
	var tiles = []
		
	for x in range(0, size):
		for y in range(0, size):
			var tile = tile_resource.instance()
			tile.position.x = x + tile_size_x * x
			tile.position.y = y + tile_size_y * y
			if Vector2(x,y) in mines:
				tile.has_mine = true
			tile.coords = Vector2(x,y)
			tiles.append(tile)

	for tile in tiles:
		if tile.has_mine:
			print(tile.has_mine)
			for n in tiles:
				if n.coords in [
					Vector2(tile.coords.x-1, tile.coords.y-1), #
					Vector2(tile.coords.x, tile.coords.y-1),
					Vector2(tile.coords.x, tile.coords.y+1),
					Vector2(tile.coords.x+1, tile.coords.y-1),
					Vector2(tile.coords.x-1, tile.coords.y+1),
					Vector2(tile.coords.x+1, tile.coords.y+1),
					Vector2(tile.coords.x-1, tile.coords.y),
					Vector2(tile.coords.x+1, tile.coords.y),
				]:
					print(n.coords)
					n.neighbouring_mines += 1
					
	for tile in tiles:
		add_child(tile)

func generate_mine_locations() -> Array:
	var mines = []
	for i in  range(0, amount_of_mines):
		mines.append(Vector2(rng.randi_range(0, size-1), rng.randi_range(0, size-1)))
	return mines
