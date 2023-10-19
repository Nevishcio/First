extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$World/CollisionPolygon2D/Polygon2D.polygon = $World/CollisionPolygon2D.polygon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if dragging:
		$Slope.global_position = get_global_mouse_position() - offset

var dragging = false
var offset = Vector2.ZERO

func _on_interact_mouse_entered():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		$Interact.queue_free()


func _on_slope_button_down():
	dragging = true
	offset = get_global_mouse_position() - $Slope.global_position


func _on_slope_button_up():
	dragging = false
