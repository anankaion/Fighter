extends Node2D


func _on_Player1_health_changed(health):
	$Camera2D/HUD/HBoxContainer/Player1Container/Player1_Health.text = str(health)


func _on_Player2_health_changed(health):
	$Camera2D/HUD/HBoxContainer/Player2Container/Player2_Health.text = str(health)
