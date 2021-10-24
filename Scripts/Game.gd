extends Node2D

var coins = 0

func _on_CoinScene_coin_collected():
	coins = coins + 1
	var CoinScore = "Coins :" + String(coins)
	Global.coins += 1
