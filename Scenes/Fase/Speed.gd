extends Label

func _process(_delta):
	self.text = "Speed (" + str(Global.data.Speed) + ")" + " - Lv (" + str(Global.data.LevelSpeed) + ")"
	
