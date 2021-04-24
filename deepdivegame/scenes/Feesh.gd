extends KinematicBody2D

var rng = RandomNumberGenerator.new()
var screen_size = Vector2(180, 320)
var speed = 20.0
var velocity = Vector2.ZERO

func _physics_process(delta):
	move_and_slide(velocity)

func init():
	var side = rng.randi_range(0, 2)
	
	if(side == 0):
		velocity.x = -1 * speed
		position.x = -20
	
	else:
		velocity.x = 1 * speed
		position.x = screen_size.x + 20
	
	position.y = rng.randi_range(0, screen_size.y)
	
	print("feesh spawned at: ", position)
