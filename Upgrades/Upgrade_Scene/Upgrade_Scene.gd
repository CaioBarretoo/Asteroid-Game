extends Node2D


var count = 0
var damage_use = false
var shotspeed_use = false
var speed_use = false
var defense_use = false

var position0 = Vector2(150,162)
var position1 = Vector2(150,392)
var position2 = Vector2(150,622)

#Upgrades
onready var Damage = $Upgrade/Damage_Box
onready var ShotSpeed = $Upgrade/ShotSpeed_Box
onready var Speed = $Upgrade/Speed_Box
onready var Defense = $Upgrade/Defense_Box


func _process(_delta):
	if count != 3 && count != 4:
		selectUpgrade()
		
func positionU(upgrade):
	if count == 0:
		upgrade.rect_position = position0
		
	if count == 1:
		upgrade.rect_position = position1
		
	if count == 2:
		upgrade.rect_position = position2
		
func selectUpgrade():
	var rng1 = RandomNumberGenerator.new()
	rng1.randomize()
	var num1 = rng1.randi_range(0, 3)
	
	if num1 == 0 && damage_use == false:
		positionU(Damage)
		count += 1
		damage_use = true
	
	if num1 == 1 && shotspeed_use == false:
		positionU(ShotSpeed)
		count += 1
		shotspeed_use = true

	if num1 == 2 && speed_use == false:
		positionU(Speed)
		count += 1
		speed_use = true
	
	if num1 == 3 && defense_use == false:
		positionU(Defense)
		count += 1
		defense_use = true
	if count == 3:
		return


func _on_Damage_Button_pressed():
	Global.data.Damage += 1
	Global.data.LevelDamage += 1
	get_tree().paused = false
	queue_free()
	Global.reload()


func _on_Speed_Button_pressed():
	Global.data.Speed += 50
	Global.data.LevelSpeed += 1
	get_tree().paused = false
	queue_free()
	Global.reload()



func _on_ShotSpeed_Button_pressed():
	Global.data.ShotSpeed = Global.data.ShotSpeed - 0.05
	Global.data.LevelShotSpeed += 1
	get_tree().paused = false
	queue_free()
	Global.reload()

func _on_DefenseButton_pressed():
	Global.data.Defense += 2
	get_tree().paused = false
	queue_free()
	Global.reload()
	Global.emit_signal("defense_changed")
