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
var damage_lock = 0.0
var charge_time = 2.5
var charge_start_time = 0.0

var slash_scene = preload("res://entities/attacks/slash.tscn")
var menu_scene = preload("res://gui.tscn")
var menu_instance = null

@onready var HUD = get_tree().get_first_node_in_group("HUD")

func get_direction_name():
	return ["side", "down", "side", "up"][
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

func charged_attack():
	data.state = STATES.ATTACKING
	$AnimatedSprite2D.play("attack_spin")
	attack_direction = look_direction
	damage_lock = 0.3
	
	for i in range(9):
		var angle = -attack_direction.angle() + (i-4) * PI / 4;
		var direction = Vector2(cos(angle), sin(angle))
		var slash = slash_scene.instantiate()
		slash.position = direction * 20.0
		slash.rotation = Vector2().angle_to_point(-direction)
		slash.damage *= 1.5
		add_child(slash)
		await get_tree().create_timer(0.03).timeout
	animation_lock = 0.2
	data.state = STATES.IDLE
	await $AnimatedSprite2D.animation_finished
	pass

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
	animation_lock = max(animation_lock-_delta, 0.0)
	if data.state != STATES.CHARGING:
			data.state = STATES.IDLE
	damage_lock = max(damage_lock-_delta, 0.0)
	if animation_lock == 0.0 and data.state != STATES.DEAD:
		var direction = Vector2(
			Input.get_axis("ui_left", "ui_right"),
			 Input.get_axis("ui_up", "ui_down")
			).normalized()
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
			charge_start_time = Time.get_time_dict_from_system().second
			data.state = STATES.CHARGING
	if Input.is_action_just_released("ui_accept"):
		var charge_duration = Time.get_time_dict_from_system().second - charge_start_time
		if charge_duration >= charge_time and data.state == STATES.CHARGING:
			charged_attack()
		else:
			data.state = STATES.IDLE
	if Input.is_action_just_pressed("ui_cancel"):
		menu_instance.show()
		get_tree().paused = true




func update_animation(direction):
	if data.state == STATES.IDLE:
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
