extends KinematicBody2D

var velocity = Vector2.ZERO
var gravity = 300

var speed = 200
var speed_reduced = 100

var in_attack = false

func _physics_process(delta):
	if not in_attack:
		# right
		if Input.is_action_pressed("ui_right"):
			if $AnimatedSprite.animation != "at":
				if is_on_floor():
					$AnimatedSprite.flip_h = false
					$AnimatedSprite.play("right")
					
					velocity.x = speed
				else:
					velocity.x = speed_reduced
				
		# left
		elif Input.is_action_pressed("ui_left"):
			if is_on_floor():
				$AnimatedSprite.flip_h = true
				$AnimatedSprite.play("right")
			
				velocity.x = -speed
			else:
				velocity.x = -speed_reduced
			
		# up
		elif Input.is_action_pressed("ui_up"):
			$AnimatedSprite.play("jump")
			
			if is_on_floor():
				velocity.y -= 200
				
		# down
		elif Input.is_action_pressed("ui_down"):
			# fall through one way collisions
			position.y += 1
			
		# basic attack
		elif Input.is_action_pressed("attack_1"):
			$AnimatedSprite.play("attack_basic")
			in_attack = true
			
		else:
			if is_on_floor():
				$AnimatedSprite.play("idle")
			else:
				$AnimatedSprite.play("down")
			velocity.x = 0
		
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_AnimatedSprite_animation_finished():
	in_attack = false
