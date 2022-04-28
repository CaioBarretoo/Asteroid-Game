extends Area2D

var damage = 1
var direction : Vector2 = Vector2.ZERO # default direction
var speed : float = 230 #put your rocket speed
var explosion = preload("res://Effect/explosion.tscn")

	
func _physics_process(delta):
	translate(direction*speed*delta)
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_Normal_area_entered(area):
	if area.is_in_group("player"):
		var Explosion = explosion.instance()
		get_parent().add_child(Explosion)
		Explosion.position = self.position
		queue_free()
		#var enemyDeadEffect = EnemyDeadEffect.instance()
		#get_parent().add_child(enemyDeadEffect)
		#enemyDeadEffect.position = self.position
