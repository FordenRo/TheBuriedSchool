extends Control

@onready var background := $Background
@onready var background_color : Color = background.color


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("ui_cancel"):
		match Input.mouse_mode:
			Input.MOUSE_MODE_CAPTURED:
				pause()
			Input.MOUSE_MODE_VISIBLE:
				resume()


func pause() -> void:
	get_tree().paused = true
	self.show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	modulate = Color.TRANSPARENT
	create_tween().tween_property(self, "modulate", Color.WHITE, 0.1)


func resume() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.1)
	tween.tween_callback(func():
		self.hide()
		get_tree().paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	)


func _on_resume_pressed() -> void:
	resume()


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_to_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
