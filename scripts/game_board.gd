extends Node2D

export(int) var size: int = 8
export(int) var amount_of_mines = 3


var tile_resource: PackedScene = preload("res://tile.tscn")

var tile_size_x: int = 16
var tile_size_y: int = 16

var dragging: bool = false;

var rng = RandomNumberGenerator.new()

var tiles = []

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
	
		
	for x in range(0, size):
		for y in range(0, size):
			var tile = tile_resource.instance()
			tile.position.x = x + tile_size_x * x
			tile.position.y = y + tile_size_y * y
			if Vector2(x,y) in mines:
				tile.has_mine = true
			tile.coords = Vector2(x,y)
			tile.connect("transitioned", self, "_on_Tile_transitioned")
			
			tiles.append(tile)

	for tile in tiles:
		if tile.has_mine:
			for n in tiles:
				if n.coords in get_neighbouring_vectors(tile.coords):
					n.neighbouring_mines += 1
					
	for tile in tiles:
		add_child(tile)

func generate_mine_locations() -> Array:
	var mines = []
	for i in  range(0, amount_of_mines):
		mines.append(Vector2(rng.randi_range(0, size-1), rng.randi_range(0, size-1)))
	return mines

func get_neighbouring_vectors(center: Vector2) -> Array:
	return [
		Vector2(center.x-1, center.y-1),
		Vector2(center.x, center.y-1),
		Vector2(center.x, center.y+1),
		Vector2(center.x+1, center.y-1),
		Vector2(center.x-1, center.y+1),
		Vector2(center.x+1, center.y+1),
		Vector2(center.x-1, center.y),
		Vector2(center.x+1, center.y),
	]

func get_neighbouring_tiles(center: Vector2) -> Array:
	var r = []
	for v in get_neighbouring_vectors(center):
		for tile in tiles:
			if tile.coords == v:
				r.append(tile)
	return r

func _on_Tile_transitioned(state_name: String, tile: Tile) -> void:
	if state_name == "Commited" and !tile.has_mine:
		flood_empty_spaces(tile)

func flood_empty_spaces(start_tile: Tile):
	if start_tile.neighbouring_mines > 0:
		return
		
	var neighbours = get_neighbouring_tiles(start_tile.coords)

	for n in neighbours:
		if n.get_node("StateMachine").state.name != "Uncommited":
			continue
		
		n.commit()
		flood_empty_spaces(n)
