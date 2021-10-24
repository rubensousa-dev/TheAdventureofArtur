extends KinematicBody2D

# can be access in the inspector
export var movementSpeed = 10
export var gravityPower = 10
export var jumpPower = 20

#importing the projectile scene
export (PackedScene) var projectile

var velocity = Vector2(0, 0)
var movementVelocity = Vector2(0, 0)
var gravity = 0

# Methods

func _physics_process(delta):
	
	Movement()
	Gravity()
	Animations()
	
	velocity = velocity.linear_interpolate(movementVelocity * 10, delta * 15)
	move_and_slide(velocity + Vector2(0, gravity), Vector2(0, -1))
	
# Player controls
func Movement():

	movementVelocity = Vector2(0, 0)
	
	if Input.is_action_pressed("left"):
	
		movementVelocity.x = -movementSpeed
		$Sprite.flip_h = true
		
	elif Input.is_action_pressed("right"):
		
		movementVelocity.x = movementSpeed
		$Sprite.flip_h = false
		
	if Input.is_action_just_pressed("jump"):
		
		if is_on_floor():
			jump(1)
			
	if Input.is_action_just_pressed("shoot"):
		shoot()


# Gravity and jump
func Gravity():

	gravity += gravityPower
	
	if gravity > 0 and is_on_floor():
		gravity = 10
		
	if is_on_ceiling(): gravity = 0
	
func jump(multiplier):
	
	gravity = -jumpPower * multiplier * 10
	
func shoot():
	
	#creating an instance of the projectile
	var _projectile = projectile.instance()
	#adding to this component
	get_tree().get_root().add_child(_projectile)
	
	if !$Sprite.flip_h:
		_projectile.direction = 1
		_projectile.position = position + Vector2(8, 2) #  spawn position
		movementVelocity.x = -movementSpeed * 2 # Knockback
	else:
		_projectile.position = position + Vector2(-8, 2) #  spawn position
		movementVelocity.x = movementSpeed * 2 # Knockback
		
#define the animations
func Animations():
	
	if is_on_floor():
		if abs(velocity.x) > 60:
			$Sprite.play("walk")
		else:
			$Sprite.play("idle")
	else:
		$Sprite.play("jump")
