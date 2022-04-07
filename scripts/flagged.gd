extends State

func handle_input_event(event: InputEvent) -> void:
	if event.is_action_released("right_click"):
		state_machine.transition_to("Uncommited")
