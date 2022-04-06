class_name State
extends Node

var state_machine = null
#var tile: Tile

func _ready() -> void:
	yield(owner, "ready")
#	tile = owner as Tile
#	assert(tile != null)
	

# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input_event(_event: InputEvent) -> void:
	pass

func handle_mouse_entered(dragging: bool) -> void:
	pass

func handle_mouse_exited(dragging: bool) -> void:
	pass
	
func commit() -> void:
	state_machine.transition_to("Commited")

func game_over() -> void:
	state_machine.transition_to("GameOver")

# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass


# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	pass


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass
