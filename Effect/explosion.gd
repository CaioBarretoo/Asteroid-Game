extends AnimatedSprite

func _ready():
	var _erro: int = connect("animation_finished", self, "_on_animation_finished")
	play("explosion")

func _on_animation_finished():
	queue_free()

