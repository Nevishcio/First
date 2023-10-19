extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_interact_mouse_entered():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		$Interact.queue_free()


func _on_button_button_down():
	dragging = true
	offset = get_global_mouse_position() - $Slope.global_position
	


func _on_button_button_up():
	dragging = false
