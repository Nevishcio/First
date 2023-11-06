extends CharacterBody2D


const SPEED = 100
var inertia = Vector2()
var look_direction = Vector2.DOWN
var menu_scene = preload("res://gui.tscn")
var menu_instance = null



func _ready():
	menu_instance = menu_scene.instantiate()
	add_child(menu_instance)
	menu_instance.hide()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().get_root().add_child.call_deferred(menu_instance)
		get_tree().paused = true

func _physics_process(_delta):
	var direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	if direction.length() > 0:
		look_direction = direction
		direction = direction.normalized()
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2(), SPEED)
	velocity += inertia
	move_and_slide()
	inertia = inertia.move_toward(Vector2(),_delta * 1000.0)
