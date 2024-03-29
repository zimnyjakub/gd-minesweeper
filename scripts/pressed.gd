extends State

func handle_input_event(event: InputEvent) -> void:
	if event.is_action_released("left_click"):
		state_machine.transition_to("Commited")

func handle_mouse_exited(dragging: bool) -> void:
	if dragging:
		state_machine.transition_to("Uncommited")

func commit() -> void:
	state_machine.transition_to("Commited")

func game_over() -> void:
	state_machine.transition_to("GameOver")
