extends KinematicBody2D

var screen_size = get_viewport_rect().size
var direction
var speed = 20.0
var velocity = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	velocity = Vector2.ZERO
	direction = Vector2.ZERO

func _physics_process(delta):
	move_and_slide(velocity)

func init(spawn_position):
	
	velocity = spawn_position.x
	position.y = spawn_position.y
	
	if(spawn_position.x < 0):
		position.x = 0
		velocity.x = 1 * speed
		
	else:
		position.x = screen_size.x
		velocity.x = -1 * speed
	print("feesh spawned at: ", position)
