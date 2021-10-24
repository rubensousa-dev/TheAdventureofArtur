extends Label

func _process(delta):
	text = "Coins" + String(Global.coins)
