extends Control

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts

onready var heartUIFull = $HeartUIFull
onready var heartUIEmpty = $HeartUIEmpty
onready var heartUIBlue = $HeartUIBlue

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heartUIFull != null:
		heartUIFull.rect_size.x = hearts * 15
	
func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heartUIEmpty != null:
		heartUIEmpty.rect_size.x = max_hearts * 15

func set_HeartBlue():
	heartUIBlue.rect_position.x = Global.health_global * 15
	if Global.defense <=0:
		heartUIBlue.visible = false
	else:
		heartUIBlue.visible = true
		heartUIBlue.rect_size.x = Global.defense * 15
	Global.reload()

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	set_HeartBlue()
	
# warning-ignore:return_value_discarded
	PlayerStats.connect("health_changed", self, "set_hearts")
	var _error = Global.connect("defense_changed",self,"set_HeartBlue")
