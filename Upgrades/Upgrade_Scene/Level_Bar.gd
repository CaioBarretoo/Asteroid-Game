extends YSort

var a = 0

onready var Upgrade_Scene = preload("res://Upgrades/Upgrade_Scene/Upgrade_Scene.tscn")
onready var level = Global.data.Level
onready var numant = 1
#onready var up_sound = get_node("../").get_node("../").get_node("LevelUp")

export(float) var more = 50

func _process(_delta):
	#up_sound.autoplay = false
	if level == 0:
		$Label.text = "Lv " + str(level)
	$Experience_Bar.value = Global.data.Xp
	levels(level)
	if $Experience_Bar.value >= $Experience_Bar.max_value:
		level += 1
		levels(level)
		get_tree().paused = true
		var s = Upgrade_Scene.instance()
		get_tree().get_root().add_child(s)
		
	else:
	#	up_sound.autoplay = true
		a = +1
	
func levels(num):
	if num == numant:
		$Label.text = "Lv " + str(level)
		#$Experience_Bar.min_value = 0
		Global.data.Xp = 0
		$Experience_Bar.max_value = $Experience_Bar.max_value + more#$Experience_Bar.max_value + more
		Global.data.Level = num
		numant+=1
		Global.data.SkillPoint = level
		#if a >= 1: 
			#up_sound.play()
		Global.save_game()
		return


