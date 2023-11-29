extends CharacterBody2D


const SPEED = 75.0
var MAX_HEALTH: float = 30.0
var HEALTH = MAX_HEALTH
var DAMAGE = 10.0
var AI_STATE = STATES.IDLE
enum STATES {IDLE = 0, UP, DOWN, LEFT, RIGHT,
			UP_L, UP_R, DOWN_L, DOWN_R, DAMAGED}
var state_directions = [
	
]

signal recovered
@onready var raycast1 = $RayCast1
@onready var raycast2 = $RayCast2
@onready var raycast3 = $RayCast3

var inertia = Vector2()
var ai_timer_max = 0.5
var ai_timer = ai_timer_max - randi() % 5
var damage_lock = 0.0
var animation_lock = 0.0
var knockback = 128.0
var vision_distance = 40.0
var money_value = 5.0

func turn_toward_player_location(location: Vector2):
	var direction_to_player = (location - global_position).normalized()
	velocity = direction_to_player * (SPEED * 2)
	var closest_angle = INF
	var closest_state = STATES.IDLE
	for i in range(1, 5):
		var state_direction = state_directions[i]
		var angle_diff = abs(state_direction.angle_to(direction_to_player))
		if angle_diff < closest_angle:
			closest_angle = angle_diff
			closest_state = STATES.values()[i]
	AI_STATE = closest_state

func _physics_process(_delta):
	animation_lock = max(animation_lock-_delta, 0.0)
	damage_lock = max(damage_lock-_delta, 0.0)
	if int(AI_STATE) >= 1 and int(AI_STATE)<= 8:
		var raydir = state_directions[int(AI_STATE)]
		raycast1.target_position = raydir * vision_distance
		raycast2.target_position = raydir.rotated(deg_to_rad(-45)).normalized * vision_distance
		raycast3.target_position = raydir.rotated(deg_to_rad(45)).normalized * vision_distance
		if animation_lock == 0.0:
			if AI_STATE == STATES.DAMAGED:
				AI_STATE = STATES.IDLE
				recovered.emit()
			for player in get_tree().get_nodes_in_group("Player"):
				if $AttackBox.overlaps_body(player):
					if player.gamaged_lock == 0.0:
						player.inertia = (player.global_position-global_position).normalized() * knockback
						player.take_damage(DAMAGE)
					else:
						return
				if player.data.state != player.STATES.DEAD:
					if (raycast1.is_colliding() and raycast1.gel_collider() == player) or \
					   (raycast1.is_colliding() and raycast1.gel_collider() == player) or \
					   (raycast1.is_colliding() and raycast1.gel_collider() == player):
						turn_toward_player_location(player.global_position)
