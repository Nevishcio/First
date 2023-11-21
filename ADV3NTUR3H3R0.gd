extends CharacterBody2D

enum STATES {IDLE=0, DEAD, DAMAGED, ATTACKING, CHARGING}

@export var data = {
	"max_health": 60.0,
	"health": 60.0,
	"money": 0,
	"book": 0,
	"state": STATES.IDLE,
	"secondaries": [],
}
const SPEED = 100
const MAX_OBTAINABLE_HEALTH = 400.0
var inertia = Vector2()
var look_direction = Vector2.DOWN
var attack_direction = Vector2.DOWN
var animation_lock = 0.0
var slash_scene = ("res://entities/attacks/slash.tscn")
var menu_scene = preload("res://gui.tscn")
var menu_instance = null

@onready var HUD = get_tree().get_first_node_in_group("HUD")

func get_direction_name():
	return ["right", "down", "left", "up"][
		int(round(look_direction.angle() * 2 / PI)) % 4
	]

func attack():
	data.state = STATES.ATTACKING
	$AnimatedSprite2D.play("attack_" + get_direction_name())
	attack_direction = look_direction
	var slash = slash_scene.instantiate()
	slash.position = attack_direction * 20
	slash.rotation = Vector2().angle_to_point(-attack_direction)
	add_child(slash)
	animation_lock = 0.2

func pickup_money(value):
	data.money += value

func pickup_heart(value):
	data.health += value
	data.health = clamp(data.health, 0, data.max_health)

func pickup_book(value):
	data.book += value

func _ready():
	HUD.show()
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
	
	if data.state != STATES.DEAD:
		if Input.is_action_just_pressed("ui_accept"):
			attack()


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
		$AnimatedSprite2D.play()
	else:
		if look_direction.x != 0:
			a_name = "idle_side"
			$AnimatedSprite2D.flip_h = look_direction.x < 0
		elif look_direction.y < 0:
			a_name = "idle_up"
		elif look_direction.y > 0:
			a_name = "idle_down"
	
	if $AnimatedSprite2D.animation != a_name:
		$AnimatedSprite2D.animation = a_name
