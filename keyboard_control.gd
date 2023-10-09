extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$World/CollisionShape2D/Polygon2D.polygon = $World/CollisionPolygon2D.polygon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
