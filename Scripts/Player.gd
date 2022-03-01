extends KinematicBody2D


func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("right")
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("right")
	elif Input.is_action_pressed("ui_up"):
		$AnimatedSprite.play("jump")
	elif Input.is_action_pressed("ui_down"):
		$AnimatedSprite.play("down")
	elif Input.is_action_pressed("attack_1"):
		$AnimatedSprite.play("attack_basic")
	else:
		$AnimatedSprite.play("idle")
		
		
