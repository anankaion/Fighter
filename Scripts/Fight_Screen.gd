extends Node2D

var health_player1 = 100
var health_player2 = 100


func _on_Player1_attacking():
	$Player1/RayCast2D.enabled = true
	
	if $Player1/RayCast2D.is_colliding() and $Player1/RayCast2D.get_collider() is KinematicBody2D:
		health_player2 -= 10	
