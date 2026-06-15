class_name Player
extends CharacterBody3D

@onready var camera: Camera3D = $CameraRig/SpringArm3D/Camera3D
@onready var camera_rig: Node3D = $CameraRig
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var visual: MeshInstance3D = $Visual
@onready var state_chart: StateChart = $StateChart
@onready var state_machine: Node = $StateMachine


func _ready() -> void:
	assert(camera != null)
	assert(camera_rig != null)
	assert(collision_shape != null)
	assert(visual != null)
	assert(state_chart != null)
	assert(state_machine != null)
