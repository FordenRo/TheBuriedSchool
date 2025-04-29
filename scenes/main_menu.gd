extends Control

@onready var version_label := $Version


func _ready() -> void:
	version_label.text = "v" + ProjectSettings.get_setting("application/config/version")


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
