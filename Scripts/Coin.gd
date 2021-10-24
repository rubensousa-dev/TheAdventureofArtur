extends Area2D

signal coin_collected

func _on_Coin_body_entered(body):
	if body.is_in_group ("Player"):
		collected()
		
func collected():
	emit_signal ("coin_collected")
	Global.coin_collected = true
	queue_free()
