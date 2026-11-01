extends Node3D

@onready var perspective_cam: Camera3D = $Perspective
@onready var orthogonal_cam: Camera3D = $Orthographic

func _unhandled_input(event: InputEvent) -> void:
	# Checks specifically for the physical "C" key being pressed
	if event is InputEventKey and event.pressed and not event.is_echo():
		if event.keycode == KEY_C:
			if perspective_cam.current:
				orthogonal_cam.make_current()
				print("Switched to Orthogonal Camera")
			else:
				perspective_cam.make_current()
				print("Switched to Perspective Camera")
