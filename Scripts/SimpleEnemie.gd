extends KinematicBody2D

export var movementSpeed = 20
export var gravityPower = 10
export var orientation = 0

# Private

var direction = 0
var gravity = 0
var is_dead = false

# Methods

func _physics_process(delta):
	
	if is_dead :
		
		gravity += gravityPower
		position.y += gravity * delta

	if orientation == 0:
		if direction == 0:

			move_and_slide(Vector2(0,  movementSpeed), Vector2(0, -1))
		else:
			move_and_slide(Vector2(0, -movementSpeed), Vector2(0, -1))
			
		if is_on_ceiling() or is_on_floor():
		
			if direction == 0: direction = 1
			elif direction == 1: direction = 0
			
	else:
		if direction == 0:

			move_and_slide(Vector2( movementSpeed, 0), Vector2(0, -1))
			$Sprite.flip_h = false
		else:

			move_and_slide(Vector2(-movementSpeed, 0), Vector2(0, -1))
			$Sprite.flip_h = true
			
		if is_on_wall():
		
			if direction == 0: direction = 1
			elif direction == 1: direction = 0

func hit():
	if is_dead : return
	#stop the movement
	$Sprite.stop()
	#disables the collider
	$Collision.call_deferred("set_disabled", true)
	#starts the Timer
	$Timer.start()

# tells to destroy the gameObject
func _on_Timer_timeout():
	queue_free()
