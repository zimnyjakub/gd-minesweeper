extends Popup


func _ready() -> void:
	pass


func _on_GameBoard_game_over() -> void:
	popup_centered(rect_size)
