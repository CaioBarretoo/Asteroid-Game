extends CanvasLayer


func _process(_delta):
	if Global.data.Score > 99:
		$CoinScore.rect_position.x = 596
	if Global.data.Score > 999:
		$CoinScore.rect_position.x = 590
	if Global.data.Score > 9999:
		$CoinScore.rect_position.x = 580
