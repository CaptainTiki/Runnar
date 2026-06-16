extends PlayerState

@export var speed: float = 6.0
@export var acceleration: float = 24.0
@export var deceleration: float = 18.0

const STOP_SPEED := 0.05


func physics_process_state(delta: float) -> void:
	var movement_input := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := _get_camera_relative_direction(movement_input)
	var target_velocity := direction * speed
	var horizontal_velocity := Vector3(player.velocity.x, 0.0, player.velocity.z)
	var rate := acceleration if movement_input != Vector2.ZERO else deceleration

	horizontal_velocity = horizontal_velocity.move_toward(target_velocity, rate * delta)
	player.velocity.x = horizontal_velocity.x
	player.velocity.z = horizontal_velocity.z
	player.move_and_slide()

	if not player.is_on_floor():
		player.state_chart.send_event(&"start_falling")
		return

	if movement_input == Vector2.ZERO and horizontal_velocity.length() <= STOP_SPEED:
		player.velocity.x = 0.0
		player.velocity.z = 0.0
		player.state_chart.send_event(&"stop_running")


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
