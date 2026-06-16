extends PlayerState


func physics_process_state(_delta: float) -> void:
	var movement_input := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	if not player.is_on_floor():
		player.state_chart.send_event(&"start_falling")
		return

	if movement_input != Vector2.ZERO:
		player.state_chart.send_event(&"start_running")
