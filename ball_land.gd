extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/GravitySlider.value = $NPC_Ball.gravity_scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var npc_ball = preload("res://npc_ball.tscn").instantiate()
		npc_ball.position = event.position
		add_child(npc_ball)


func _on_gravity_slider_value_changed(value):
	for child in get_children():
		if child is RigidBody2D:
			child.gravity_scale = value
