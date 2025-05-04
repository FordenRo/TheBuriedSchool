extends TabContainer


func _on_show_fps_toggled(toggled_on: bool) -> void:
	GameManager.fps_visible = toggled_on
