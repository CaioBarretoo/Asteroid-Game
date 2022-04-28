extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	Global.reload()
func _process(_delta):
	self.text = "Level = " + str(Global.level_shot_speed)
	
