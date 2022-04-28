extends Node2D

var spawn_positions = null
var num1 

#Enemy
var enemy
var Enemy1 = preload("res://Inimigos/Naves/Ship1/Ship1.tscn")
var Enemy2 = preload("res://Inimigos/Naves/Ship2/Ship2.tscn")
var Boss1 = preload("res://Inimigos/Bosses/Boss1.tscn")

#Enemy Activation
var Boss1_Active = false

func _ready():
	randomize()
	spawn_positions = $SpawnPositions.get_children()
	
func spawn_enemy():
	var rng1 = RandomNumberGenerator.new()
	rng1.randomize()
	var index = randi() % spawn_positions.size()
	
	if Global.score >= 600 && Global.score <= 900:
		num1 = 0
	if Global.score < 600 || Global.score >= 900:
		if Global.score < 200:
			num1 = 1;
	if Global.score < 600 || Global.score >= 900:
		if Global.score >= 200:
			num1 = rng1.randi_range(1, 3)
			
	print(num1)
	if num1 == 1:
		enemy = Enemy1.instance()
		enemy.global_position = spawn_positions[index].global_position
		add_child(enemy)
	if (num1 == 2 || num1 == 3) && Global.score >= 200:
		enemy = Enemy2.instance()
		enemy.global_position = spawn_positions[index].global_position
		add_child(enemy)
	if Global.score >= 600 && Boss1_Active == false:
		enemy = Boss1.instance()
		enemy.global_position = $SpawnBoss/Spawn_Position1.global_position
		add_child(enemy)
		Boss1_Active = true
		

func _on_SpawnTimer_timeout():
	spawn_enemy()
