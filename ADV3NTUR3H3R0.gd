extends CharacterBody2D


const SPEED = 130
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
	var direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized()
	update_animation(direction)
	if direction.length() > 0:
		look_direction = direction
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2(), SPEED)
	velocity += inertia
	move_and_slide()
	inertia = inertia.move_toward(Vector2(),_delta * 1000.0)


func update_animation(direction):
	var a_name = "idle_down"
	if direction.length() > 0:
		look_direction = direction
		a_name = "walk_"
		if direction.x != 0:
			a_name += "side"
			$AnimatedSprite2D.flip_h = direction.x < 0
		elif direction.y < 0:
			a_name += "up"
		elif direction.y > 0:
			a_name += "down"
	else:
		pass
	
	if $AnimatedSprite2D.animation != a_name:
		$AnimatedSprite2D.animation = a_name
