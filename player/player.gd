extends CharacterBody3D

const SPEED := 5.0

@onready var _camera: Camera3D = $CameraRig/SpringArm3D/Camera3D

var _gravity := float(ProjectSettings.get_setting("physics/3d/default_gravity"))


func _physics_process(delta: float) -> void:
	var input_vector := Vector2.ZERO
	if Input.is_key_pressed(KEY_D):
		input_vector.x += 1.0
	if Input.is_key_pressed(KEY_A):
		input_vector.x -= 1.0
	if Input.is_key_pressed(KEY_S):
		input_vector.y += 1.0
	if Input.is_key_pressed(KEY_W):
		input_vector.y -= 1.0

	var move_direction := Vector3.ZERO
	if input_vector.length_squared() > 0.0:
		input_vector = input_vector.normalized()
		var camera_basis := _camera.global_transform.basis
		var camera_forward := -camera_basis.z
		var camera_right := camera_basis.x
		camera_forward.y = 0.0
		camera_right.y = 0.0
		camera_forward = camera_forward.normalized()
		camera_right = camera_right.normalized()
		move_direction = (camera_right * input_vector.x) + (camera_forward * -input_vector.y)

	velocity.x = move_direction.x * SPEED
	velocity.z = move_direction.z * SPEED

	if not is_on_floor():
		velocity.y -= _gravity * delta
	elif velocity.y < 0.0:
		velocity.y = 0.0

	move_and_slide()
