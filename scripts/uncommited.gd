extends State


func handle_input_event(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		state_machine.transition_to("Pressed")
	if event.is_action_released("right_click"):
		state_machine.transition_to("Flagged")

func handle_mouse_entered(dragging: bool) -> void:
	if dragging:
		state_machine.transition_to("Pressed")
