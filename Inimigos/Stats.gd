extends "res://Global/Global.gd"

export (int) var max_health = data.HealthGlobal
var health = max_health setget set_health
#const GameOverScreen = preload("res://background_menu/Script/GameOverScreen.tscn")

signal no_health
signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed")

func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")
		#GameOver()
		
func _ready():
	self.health = max_health
#Função GameOver
#func GameOver():
#	var game_over = GameOverScreen.instance()
#	add_child(game_over)
