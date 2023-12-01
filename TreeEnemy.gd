extends CharacterBody2D


const SPEED = 60.0
var MAX_HEALTH: float = 30.0
var HEALTH = MAX_HEALTH
var DAMAGE = 10.0
var AI_STATE = STATES.IDLE

enum STATES { IDLE=0, UP, DOWN, LEFT, RIGHT,
			  UP_L, UP_R, DOWN_L, DOWN_R, DAMAGED }

var state_directions = [
	Vector2.ZERO,
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT,
	Vector2(-1, -1).normalized(),  # UL
	Vector2(1, -1).normalized(),   # UR
	Vector2(-1, 1).normalized(),   # DL
	Vector2(1, 1).normalized(),    # DR
	Vector2.ZERO
]

var inertia = Vector2()
var ai_timer_max = 0.5
var ai_timer = ai_timer_max - randi() % 5
var damage_lock = 0.0
var animation_lock = 0.0
var knockback = 128.0
var vision_distance = 40.0
var money_value = 5.0

signal recovered

@onready var raycastR = $RayCast2DR
@onready var raycastM = $RayCast2DM
@onready var raycastL = $RayCast2DL

func turn_toward_player_location(location: Vector2):
	# Set the satte to move toward the player
	var dir_to_player = (location - global_position).normalized()
	velocity = dir_to_player * (SPEED * 2)
	# Determine the closest cardinal direction for animation
	var closest_angle = INF
	var closest_state = STATES.IDLE
	for i in range(1, 5):
		var state_dir = state_directions[i]
		var angle_diff = abs(state_dir.angle_to(dir_to_player))
		if angle_diff < closest_angle:
			closest_angle = angle_diff
			closest_state = STATES.values()[i]
	AI_STATE = closest_state


func take_damage(dmg, attacker=null):
	if damage_lock == 0.0:
		AI_STATE = STATES.DAMAGED
		HEALTH -= dmg
		damage_lock = 0.2
		animation_lock = 0.2
		# TODO: damage intensity & shader
		if HEALTH <= 0:
			# TODO: drop item and play sound
			queue_free()
		else:
			if attacker != null:
				var location = attacker.global_position
				await recovered
				turn_toward_player_location(location)
	pass


func _physics_process(delta):
	animation_lock = max(animation_lock-delta, 0.0)
	damage_lock = max(damage_lock-delta, 0.0)
	if int(AI_STATE) >= 1 and int(AI_STATE) <= 8:
		var raydir = state_directions[int(AI_STATE)]
		raycastM.target_position = raydir * vision_distance
		raycastL.target_position = \
			raydir.rotated(deg_to_rad(-45)).normalized() * vision_distance
		raycastR.target_position = \
			raydir.rotated(deg_to_rad(45)).normalized() * vision_distance
	
	if animation_lock == 0.0:
		if AI_STATE == STATES.DAMAGED:
			AI_STATE = STATES.IDLE
			recovered.emit()
		
		for player in get_tree().get_nodes_in_group("Player"):
			if $AttackBox.overlaps_body(player):
				if player.damage_lock == 0.0:
					player.inertia = \
						(player.global_position-global_position).normalized() \
							* knockback
					player.take_damage(DAMAGE)
				else:
					return
			if player.data.state != player.STATES.DEAD:
				if (raycastM.is_colliding() and raycastM.get_collider() == player) or \
				   (raycastL.is_colliding() and raycastL.get_collider() == player) or \
				   (raycastR.is_colliding() and raycastR.get_collider() == player):
					turn_toward_player_location(player.global_position)
		
		ai_timer = clamp(ai_timer-delta, 0.0, ai_timer_max)
		if ai_timer == 0.0:
			if AI_STATE == STATES.IDLE:
				var rnd_mov = randi() % 4
				AI_STATE = STATES.values()[rnd_mov+1]
			else:
				AI_STATE = STATES.IDLE
			ai_timer = ai_timer_max
		
		var direction = state_directions[int(AI_STATE)]
		velocity = direction * SPEED
		
		# TODO: walk animation stuff
		
		velocity += inertia
		move_and_slide()
		inertia = inertia.move_toward(Vector2(), delta * 1000.0)
	pass
