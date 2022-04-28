extends ParallaxBackground


func _process(delta):
	scroll_offset.y += 200 * delta
	if PlayerStats.health <= 0:
		queue_free()
		Global.reset()
		var _error: int = get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
		PlayerStats.health = PlayerStats.max_health
