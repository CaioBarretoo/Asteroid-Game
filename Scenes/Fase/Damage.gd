extends Label


func _process(_delta):
	self.text = "Damage (" + str(Global.data.Damage) + ")" + " - Lv (" + str(Global.data.LevelDamage) + ")"

