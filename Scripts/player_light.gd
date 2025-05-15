extends Node2D

@export var jitter_offset := 0.25
@export var jitter_speed := 6.0
@export_range(0.0, 1.0) var jitter_min_energy := 0.95

var progress := 0.0

func _process(delta: float) -> void:
	progress += delta * jitter_speed
	if progress >= 1.0:
		progress -= 1.0
		jitter()

func jitter() -> void:
	var p := Vector2(randf_range(-jitter_offset, jitter_offset),
					randf_range(-jitter_offset, jitter_offset)
	)
	$PointLight2D.position = p
	
	var e := randf_range(jitter_min_energy, 1.0)
	$PointLight2D.energy = e
