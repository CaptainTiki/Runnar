class_name PlayerState
extends Node

@export var player_path: NodePath
@export_node_path("StateChartState") var state_path: NodePath

var player: Player
var state: StateChartState


func _ready() -> void:
	player = get_node_or_null(player_path) as Player
	state = get_node_or_null(state_path) as StateChartState

	assert(player != null)
	assert(state != null)

	state.state_entered.connect(enter)
	state.state_exited.connect(exit)
	state.state_processing.connect(process_state)
	state.state_physics_processing.connect(physics_process_state)
	state.state_input.connect(input_state)
	state.state_unhandled_input.connect(unhandled_input_state)


func enter() -> void:
	pass


func exit() -> void:
	pass


func process_state(_delta: float) -> void:
	pass


func physics_process_state(_delta: float) -> void:
	pass


func input_state(_event: InputEvent) -> void:
	pass


func unhandled_input_state(_event: InputEvent) -> void:
	pass
