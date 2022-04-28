extends Node2D

var speed = 150

func _physics_process(delta):
	global_position.y += speed * delta


func _on_Area2D_body_entered(body):
	Global.load_game()
	if body.name == "Player":
		Global.data.Damage = Global.data.Damage + 1
		Global.data.LevelDamage += 1
		Global.save_game()
		Global.load_game()
		queue_free()
