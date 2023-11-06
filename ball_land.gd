extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/GravitySlider.value = $NPC_Ball.gravity_scale
	$Panel/GravitySlider.value = $NPC_Pink_Ball.gravity_scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_page_up"):
		var npc_pink_ball = preload("res://npc_pink_ball.tscn").instantiate()
		npc_pink_ball.position = ("Panel3")
		add_child(npc_pink_ball)



func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var npc_ball = preload("res://npc_ball.tscn").instantiate()
		npc_ball.position = event.position
		add_child(npc_ball)


func _on_gravity_slider_value_changed(value):
	for child in get_children():
		if child is RigidBody2D:
			child.gravity_scale = value






