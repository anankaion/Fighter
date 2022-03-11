extends Node2D


func _physics_process(delta):
	$Camera2D/HUD/VBoxContainer/TimerLabel.text = str(round($Timer.time_left))

func _on_Player1_health_changed(health):
	$Camera2D/HUD/VBoxContainer/HBoxContainer/Player1Container/Player1_Health.text = str(health)


func _on_Player2_health_changed(health):
	$Camera2D/HUD/VBoxContainer/HBoxContainer/Player2Container/Player2_Health.text = str(health)


func _on_Player1_gauge_changed(gauge):
	$Camera2D/HUD/VBoxContainer/HBoxContainer/Player1Container/Player1_Gauge.text = str(gauge)


func _on_Player2_gauge_changed(gauge):
	$Camera2D/HUD/VBoxContainer/HBoxContainer/Player2Container/Player2_Gauge.text = str(gauge)


func _on_Player1_death():
	$Camera2D/Win_Label.text = "Player 2 wins!"
	$Camera2D/Win_Label.visible = true


func _on_Player2_death():
	$Camera2D/Win_Label.text = "Player 1 wins!"
	$Camera2D/Win_Label.visible = true


func _on_Player1_death_animation_finished():
	$Player1.queue_free()
	

func _on_Player2_death_animation_finished():
	$Player2.queue_free()


func _on_Timer_timeout():
	var player1_health = int($Camera2D/HUD/VBoxContainer/HBoxContainer/Player1Container/Player1_Health.text)
	var player2_health = int($Camera2D/HUD/VBoxContainer/HBoxContainer/Player2Container/Player2_Health.text)
	
	if player1_health > player2_health:
		$Camera2D/Win_Label.text = "Player 1 wins!"
	elif player2_health > player1_health:
		$Camera2D/Win_Label.text = "Player 2 wins!"
	else:
		$Camera2D/Win_Label.text = "Draw!"
	
	$Camera2D/Win_Label.visible = true
