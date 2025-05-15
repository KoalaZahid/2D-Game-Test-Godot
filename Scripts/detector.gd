class_name Detector
extends Area2D

signal validity_changed(valid : bool)

@export_color_no_alpha var invalid_color := Color.RED
@export_color_no_alpha var valid_color := Color.GREEN

@export_range(0.1, 1.0) var pulse_frequency := 0.25

#var sprite : Sprite2D
var object_count := 0
var pulse_progress := 0.0

func _ready() -> void:
	#sprite = get_node("Sprite2D")
	pulse_progress = randf()

func _process(delta: float) -> void:
	if object_count == 0:
		pulse_progress += delta * pulse_frequency
		if pulse_progress >= 1.0:
			pulse_progress -= 1.0

		var brightness := cos(pulse_progress * TAU) * 0.25 + 0.75
		$Sprite2D.modulate = Color(
				invalid_color.r * brightness,
				invalid_color.g * brightness,
				invalid_color.b * brightness
		)

func _on_body_entered(body: Node2D) -> void:
	if object_count == 0:
		$Sprite2D.modulate = valid_color
		validity_changed.emit(true)
	object_count += 1

func _on_body_exited(body: Node2D) -> void:
	object_count -= 1
	if object_count == 0:
		#sprite.modulate = invalid_color
		pulse_progress = 0.0
		validity_changed.emit(false)
