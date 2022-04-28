extends KinematicBody2D

export (int) var speed = 150

export onready var stats = preload("res://Inimigos/Naves/Stats_Ship.gd")
onready var xp = preload("res://Upgrades/Upgrade_Scene/XP.tscn")
export var BULLET_SCENE = preload("res://Inimigos/Attacks/Bullet_Normal.tscn")
onready var timer = get_node("Timer_Shot")

func _ready():
	fire()
	
func _physics_process(delta):
	global_position.y += speed * delta
	if Global.score >= 600 && Global.score < 900:
		queue_free()

func _on_Stats_Ship_no_health():
	if $Stats_Ship.health <= 0:
		Global.xp_enemy = 30
		Global.data.Score += 20
		drop_xp(global_position,Vector2(0,0))
		#Global.data.Xp += 100
		Global.reload()
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

func fire():
	var roc = BULLET_SCENE.instance()
	get_tree().get_root().add_child(roc)
	roc.global_position = $Sprite.global_position + Vector2(0, 40)#bullet_position.global_position
	var dir = Vector2.ZERO
	dir += dir + Vector2(0, 1.5)
	roc.direction = dir
	timer.set_wait_time(3)
	timer.start()
	
func _on_Timer_Shot_timeout():
	fire()
