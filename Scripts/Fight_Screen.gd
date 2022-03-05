extends Node2D



func _on_Player1_health_changed(health):
	$Camera2D/HUD/HBoxContainer/Player1Container/Player1_Health.text = str(health)


func _on_Player2_health_changed(health):
	$Camera2D/HUD/HBoxContainer/Player2Container/Player2_Health.text = str(health)


func _on_Player1_gauge_changed(gauge):
	$Camera2D/HUD/HBoxContainer/Player1Container/Player1_Gauge.text = str(gauge)


func _on_Player2_gauge_changed(gauge):
	$Camera2D/HUD/HBoxContainer/Player2Container/Player2_Gauge.text = str(gauge)


func _on_Player1_death():
	$Camera2D/Win_Label.text = "Player 1 wins!"
	$Camera2D/Win_Label.visible = true


func _on_Player2_death():
	$Camera2D/Win_Label.text = "Player 2 wins!"
	$Camera2D/Win_Label.visible = true
