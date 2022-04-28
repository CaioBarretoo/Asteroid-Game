extends Sprite

var speed = 120
var num1
var num
func _ready():
	var rng1 = RandomNumberGenerator.new()
	rng1.randomize()
	num1 = rng1.randi_range(0, 3)
	num = num1
	if num1 == num:
		frame = num
		
func _physics_process(delta):
	global_position.y += speed * delta
