extends PlayerState

@export var gravity: float = 24.0
@export var air_speed: float = 4.0
@export var air_acceleration: float = 8.0


func physics_process_state(delta: float) -> void:
	var movement_input := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := _get_camera_relative_direction(movement_input)
	var target_velocity := direction * air_speed
	var horizontal_velocity := Vector3(player.velocity.x, 0.0, player.velocity.z)

	player.velocity.y -= gravity * delta
	horizontal_velocity = horizontal_velocity.move_toward(target_velocity, air_acceleration * delta)
	player.velocity.x = horizontal_velocity.x
	player.velocity.z = horizontal_velocity.z
	player.move_and_slide()

	if player.is_on_floor():
		if movement_input != Vector2.ZERO:
			player.state_chart.send_event(&"landed_running")
		else:
			player.state_chart.send_event(&"landed_idle")


func _get_camera_relative_direction(movement_input: Vector2) -> Vector3:
	if movement_input == Vector2.ZERO:
		return Vector3.ZERO

	var camera_basis := player.camera.global_transform.basis
	var forward := -camera_basis.z
	var right := camera_basis.x
	forward.y = 0.0
	right.y = 0.0
	forward = forward.normalized()
	right = right.normalized()

	return (right * movement_input.x - forward * movement_input.y).normalized()
