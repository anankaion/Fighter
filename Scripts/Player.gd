extends KinematicBody2D

signal attack_hit(attack_type)
signal blocking_started
signal blocking_ended

export var player = "p1_"

var gravity = 300
var speed = 200
var speed_reduced = 100

var raycast_normal = Vector2(30, 0)

var velocity = Vector2.ZERO
var in_attack = false
var last_direction = "right"


func _physics_process(delta):
	if not Input.is_action_pressed(player + "block"):
		emit_signal("blocking_ended")
	
	if not in_attack:
		# right
		if Input.is_action_pressed(player + "right"):
			if is_on_floor():
				$AnimatedSprite.flip_h = false
				$AnimatedSprite.play("right")
				
				velocity.x = speed
			else:
				velocity.x = speed_reduced
			
			last_direction = "right"
			
		# left
		elif Input.is_action_pressed(player + "left"):
			if is_on_floor():
				$AnimatedSprite.flip_h = true
				$AnimatedSprite.play("right")
			
				velocity.x = -speed
			else:
				velocity.x = -speed_reduced
			
			last_direction = "left"
			
		# up
		elif Input.is_action_pressed(player + "up"):
			$AnimatedSprite.play("jump")
			
			if is_on_floor():
				velocity.y -= speed
				
		# down
		elif Input.is_action_pressed(player + "down"):
			# fall through one way collisions
			position.y += 1
			
		# basic attack
		elif Input.is_action_just_pressed(player + "attack_1"):
			$AnimatedSprite.play("attack_basic")
			
			# set direction of raycast according to last facing side
			if last_direction == "right":
				$RayCast2D.cast_to = raycast_normal
			else:
				$RayCast2D.cast_to = Vector2(-raycast_normal.x, raycast_normal.y)
				
			# get collision
			$RayCast2D.force_raycast_update()
			if $RayCast2D.is_colliding() and $RayCast2D.get_collider() is KinematicBody2D:
				emit_signal("attack_hit", "basic")
			
			in_attack = true
			
		# block
		elif Input.is_action_pressed(player + "block"):
			$AnimatedSprite.play("block")
			emit_signal("blocking_started")
		
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

# block input until attack is finished
func _on_AnimatedSprite_animation_finished():
	in_attack = false
