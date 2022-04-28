extends Particles2D


var speed = 500
var receveid

func _ready():
	receveid = Global.xp_enemy
	emitting = true
	
func _process(delta):
	global_position.y += speed * delta

func Xp_Received():
	Global.data.Xp += Global.xp_enemy

func _on_Area2D_area_entered(_area):
	var _error = Global.connect("xp", self, "Xp_Received")
	Global.emit_signal("xp")
	queue_free()
