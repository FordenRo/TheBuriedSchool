extends Label

var last_fps = 0


func _process(delta: float) -> void:
	if GameManager.fps_visible:
		if not visible:
			show()
			_main_loop()
	else:
		if visible:
			hide()
		return
		
	last_fps = lerpf(last_fps, 1 / delta, min(delta * 10, 1))


func _main_loop() -> void:
	while true:
		if not GameManager.fps_visible:
			return
			
		text = "FPS: %d" % last_fps
		await get_tree().create_timer(1.0 / 5).timeout


func _ready() -> void:
	_main_loop()
