extends Label


func _process(_delta):
	self.text = "Shot Speed (" + str(Global.data.ShotSpeed) + ")" + " - Lv (" + str(Global.data.LevelShotSpeed) + ")"
