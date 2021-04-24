extends KinematicBody2D


#variables
export var movespeed_x = 50
export var movespeed_y = 50

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = true
	screen_size = get_viewport_rect().size


# called every physics frame, which is before each drawn frame
func _physics_process(delta):
	var velocity = Vector2()
	var sink = Vector2(0,3)  # sinking vector
	
	velocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * movespeed_x
	velocity.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")) * movespeed_y
	
	var move_vector = (velocity + sink)
	
	velocity = move_and_slide(move_vector)
	
	position.x = clamp(position.x, 0, screen_size.x)
	
	# animation
	var flip = velocity.x < 0
	$AnimatedSprite.flip_h = flip
	# slow animation if not moving
	if abs(velocity.x) > 0:
		$AnimatedSprite.animation = "swim_h"
	else:
		$AnimatedSprite.animation = "idle"

func _process(delta):
	pass
