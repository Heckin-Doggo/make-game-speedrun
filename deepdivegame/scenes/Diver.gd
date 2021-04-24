extends KinematicBody2D


#variables
export var maxspeed = 80
export var acceleration = 500
export var friction = 500
var input_vector = Vector2.ZERO
var sink_speed = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# called every physics frame, which is before each drawn frame
func _physics_process(delta):
	var velocity = Vector2()
	
	input_vector.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	input_vector.y = (Input.get_action_strength("ui.down") - Input.get_action_strength("ui_up"))
	
	
	input_vector = input_vector.normalized()
	
	#adds the sink speed
	input_vector.y = input_vector.y + sink_speed
	
	if(input_vector != Vector2.ZERO):
		#moves velocity towards the input
		velocity = velocity.move_toward(input_vector * maxspeed, acceleration * delta)
		
	else:
		#moves velocity toward sink speed
		velocity = velocity.move_toward(Vector2(0, sink_speed), friction * delta)
	
	velocity = move_and_slide(velocity)
