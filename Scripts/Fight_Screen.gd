extends Node2D

signal p1_health_changed
signal p2_health_changed
signal p1_gauge_changed
signal p2_gauge_changed

signal p1_dying
signal p2_dying

signal p1_hit
signal p2_hit

var p1_health = 100
var p2_health = 100
var p1_gauge = 0
var p2_gauge = 0

var damage = 10
var p1_damage_modifier = 1
var p2_damage_modifier = 1

func _ready():
	$Camera2D/HUD/HBoxContainer/Player1Container/Player1_Health.text = str(p1_health)
	$Camera2D/HUD/HBoxContainer/Player2Container/Player2_Health.text = str(p2_health)
	$Camera2D/HUD/HBoxContainer/Player1Container/Player1_Gauge.text = str(p1_gauge)
	$Camera2D/HUD/HBoxContainer/Player2Container/Player2_Gauge.text = str(p2_gauge)

func _physics_process(delta):
	check_win()
	

func check_win():
	if p2_health <= 0:
		emit_signal("p2_dying")
		$Camera2D/Win_Label.text = "Player 1 wins!"
		$Camera2D/Win_Label.visible = true
		
	if p1_health <= 0:
		emit_signal("p1_dying")
		$Camera2D/Win_Label.text = "Player 2 wins!"
		$Camera2D/Win_Label.visible = true
	
func _on_Player1_blocking_started():
	p1_damage_modifier = 0.1


func _on_Player1_blocking_ended():
	p1_damage_modifier = 1


func _on_Player1_attack_hit(attack_type):
	if attack_type == "basic":
		p2_health -= damage * p2_damage_modifier
		p1_gauge += 5
	
	emit_signal("p2_hit")
	
	emit_signal("p2_health_changed")
	emit_signal("p1_gauge_changed")


func _on_Node2D_p1_gauge_changed():
	$Camera2D/HUD/HBoxContainer/Player1Container/Player1_Gauge.text = str(p1_gauge)


func _on_Node2D_p1_health_changed():
	$Camera2D/HUD/HBoxContainer/Player1Container/Player1_Health.text = str(p1_health)


func _on_Node2D_p2_gauge_changed():
	$Camera2D/HUD/HBoxContainer/Player2Container/Player2_Gauge.text = str(p2_gauge)


func _on_Node2D_p2_health_changed():
	$Camera2D/HUD/HBoxContainer/Player2Container/Player2_Health.text = str(p2_health)
