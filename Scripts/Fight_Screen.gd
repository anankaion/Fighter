extends Node2D

var p1_health = 100
var p2_health = 100

var p1_gauge = 0
var p2_gauge = 0

var damage = 10
var p1_damage_modifier = 1
var p2_damage_modifier = 1

func _physics_process(delta):
	$Label.text = str(p2_health)
	$Label2.text = str(p1_damage_modifier)


func _on_Player1_blocking_started():
	p1_damage_modifier = 0.1


func _on_Player1_blocking_ended():
	p1_damage_modifier = 1


func _on_Player1_attack_hit(attack_type):
	if attack_type == "basic":
		p2_health -= damage * p2_damage_modifier
		p1_gauge += 5
