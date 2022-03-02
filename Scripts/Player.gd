extends KinematicBody2D

signal attacking
signal blocking_started
signal blocking_ended

var gravity = 300
var speed = 200
var speed_reduced = 100

var velocity = Vector2.ZERO
var in_attack = false

func _physics_process(delta):
	if not Input.is_action_pressed("p1_block"):
		emit_signal("blocking_ended")
	
	if not in_attack:
		# right
		if Input.is_action_pressed("p1_right"):
			if is_on_floor():
				$AnimatedSprite.flip_h = false
				$AnimatedSprite.play("right")
				
				velocity.x = speed
			else:
				velocity.x = speed_reduced
			
		# left
		elif Input.is_action_pressed("p1_left"):
			if is_on_floor():
				$AnimatedSprite.flip_h = true
				$AnimatedSprite.play("right")
			
				velocity.x = -speed
			else:
				velocity.x = -speed_reduced
			
		# up
		elif Input.is_action_pressed("p1_up"):
			$AnimatedSprite.play("jump")
			
			if is_on_floor():
				velocity.y -= 200
				
		# down
		elif Input.is_action_pressed("p1_down"):
			# fall through one way collisions
			position.y += 1
			
		# basic attack
		elif Input.is_action_just_pressed("p1_attack_1"):
			$AnimatedSprite.play("attack_basic")
			in_attack = true
			
			emit_signal("attacking")
			
		# block
		elif Input.is_action_pressed("p1_block"):
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
