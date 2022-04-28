extends KinematicBody2D


export (int) var speed = 150
export onready var stats = preload("res://Inimigos/Naves/Stats_Ship.gd")
onready var xp = preload("res://Upgrades/Upgrade_Scene/XP.tscn")
func _physics_process(delta):
	global_position.y += speed * delta
	if Global.score >= 600 && Global.score < 900:
		queue_free()

func _on_Stats_Ship_no_health():
	if $Stats_Ship.health <= 0:
		Global.xp_enemy = 10
		Global.data.Score += 20
		drop_xp(global_position,Vector2(0,0))
		#Global.data.Xp += 100
		Global.save_game()
		Global.load_game()
		queue_free()

func _on_HurtBox_area_entered(area):
	if area.name != "HurtBoxPlayer":
		$Stats_Ship.health -= Global.damage


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func drop_xp(position, position2):
	var xP = xp.instance()
	xP.global_position = position + position2
	get_tree().get_root().call_deferred("add_child", xP)
