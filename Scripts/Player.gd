extends KinematicBody2D

export var player_name : String

signal attack_hit(damage)
signal health_changed(health)
signal gauge_changed(gauge)

signal death
signal death_animation_finished

export var health = 100
var gauge = 0

var damage = 10
var damage_modifier = 1

var gravity = 300
var speed = 200
var speed_reduced = 100

var raycast_normal = Vector2(30, 0)
var raycast_huge = Vector2(100, 0)

var velocity = Vector2.ZERO
var block_input = false
var last_direction = "right"


func _ready():
	# to update fight screen at beginning
	emit_signal("health_changed", health)
	emit_signal("gauge_changed", gauge)


func _physics_process(delta):
		
	if not block_input:
		# right
		if Input.is_action_pressed(player_name + "right"):
			if is_on_floor():
				$AnimatedSprite.flip_h = false
				$AnimatedSprite.play("right")
				
				velocity.x = speed
			else:
				velocity.x = speed_reduced
			
			last_direction = "right"
			
		# left
		elif Input.is_action_pressed(player_name + "left"):
			if is_on_floor():
				$AnimatedSprite.flip_h = true
				$AnimatedSprite.play("right")
			
				velocity.x = -speed
			else:
				velocity.x = -speed_reduced
			
			last_direction = "left"
			
		# up
		elif Input.is_action_pressed(player_name + "up"):
			$AnimatedSprite.play("jump")
			
			if is_on_floor():
				velocity.y -= speed
				
		# down
		elif Input.is_action_pressed(player_name + "down"):
			# fall through one way collisions
			position.y += 1
			
		# basic attack
		elif Input.is_action_just_pressed(player_name + "attack_1"):
			$AnimatedSprite.play("attack_basic")
			attack("basic")
			block_input = true
			
		# gauge attack
		elif Input.is_action_just_pressed(player_name + "attack_2"):
			$AnimatedSprite.play("attack_g1")
			attack("g1")
			block_input = true
			
		# block
		elif Input.is_action_pressed(player_name + "block"):
			$AnimatedSprite.play("block")
			damage_modifier = 0.1
		
		# if no input
		else:
			# when standing play idle
			if is_on_floor():
				$AnimatedSprite.play("idle")
			# if falling play down
			else:
				$AnimatedSprite.play("down")
			velocity.x = 0
	

	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	

func attack(attack_type):
	var raycast
	
	if attack_type == "basic":
		raycast = raycast_normal
	elif attack_type == "g1":
		raycast = raycast_huge
	
	# set direction of raycast according to last facing side
	if last_direction == "right":
		$RayCast2D.cast_to = raycast
	else:
		$RayCast2D.cast_to = Vector2(-raycast.x, raycast.y)
		
	# get collision
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding() and $RayCast2D.get_collider() is KinematicBody2D:
		gauge += 5
		emit_signal("attack_hit", 5)
		emit_signal("gauge_changed", gauge)
		
		
func get_damage(damage):
	health -= damage * damage_modifier
	emit_signal("health_changed", health)
	
	# check win condition
	if health <= 0:
		$AnimatedSprite.play("die")
		block_input = true
		emit_signal("death")

# block input until attack is finished
func _on_AnimatedSprite_animation_finished():
	block_input = false
	
	if $AnimatedSprite.animation == "die":
		emit_signal("death_animation_finished")

func _on_Player1_attack_hit(damage):
	get_damage(damage)

func _on_Player2_attack_hit(damage):
	get_damage(damage)
