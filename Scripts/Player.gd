extends KinematicBody2D


func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.play("right")
		
