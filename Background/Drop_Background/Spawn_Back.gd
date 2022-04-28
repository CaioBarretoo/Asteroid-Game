extends Node

var spawn_positions = null
var asteroid
var Asteroid = preload("res://Background/Drop_Background/Objects/Asteroid.tscn")
var drop = false
var index

func _ready():
	randomize()
	spawn_positions = $SpawnPositions_a.get_children()

func spawn_back():
	index = randi() % spawn_positions.size()
	if drop == false:
		asteroid = Asteroid.instance()
		asteroid.global_position = spawn_positions[index].global_position
		add_child(asteroid)
		drop = true

func _on_SpawnTimer_timeout():
	drop = false
	spawn_back()
