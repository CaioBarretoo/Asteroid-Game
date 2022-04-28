extends Node2D

var speed = 150

func _physics_process(delta):
	global_position.y += speed * delta


func _on_Area2D_body_entered(body):
	Global.load_game()
	if body.name == "Player":
		print("começou")
		Global.data.ShotSpeed = Global.data.ShotSpeed - 0.05
		Global.data.LevelShotSpeed += 1
		Global.save_game()
		Global.load_game()
		queue_free()

