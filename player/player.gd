class_name PlayerCharacter
extends CharacterBody3D

@export var SPEED := 2.0
@export var SPRINT_SPEED := 2.5
@export var JUMP_FORCE := 1.0
@export var mouse_sensivity := 0.1

@onready var head := $Head
@onready var camera := $Head/Camera3D
@onready var mesh := $MeshInstance3D
var speed := SPEED
@export var spawn_position : Vector3


func _ready() -> void:
	mesh.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		if position.y < -10:
			# kill
			pass
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += JUMP_FORCE
	
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		self.rotation_degrees.y -= event.relative.x * mouse_sensivity
		head.rotation_degrees.x -= event.relative.y * mouse_sensivity
