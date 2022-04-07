extends Label

onready var remaining_amount_of_mines: int = get_parent().get_parent().get_node("GameBoard").amount_of_mines

func _ready() -> void:
	text = "REMAINING MINES: %s" % remaining_amount_of_mines

func _on_Tile_transitioned(previous_state: String, state_name: String, tile: Tile) -> void:
	if state_name == "Flagged":
		remaining_amount_of_mines -= 1
	if previous_state == "Flagged" and state_name == "Uncommited":
		remaining_amount_of_mines += 1
	
	text = "REMAINING MINES: %s" % remaining_amount_of_mines
