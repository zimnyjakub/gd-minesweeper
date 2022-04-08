extends Label

func _physics_process(delta: float) -> void:
	text = "uncovered tiles %s" % get_node("../../../GameBoard").uncommited_tiles
