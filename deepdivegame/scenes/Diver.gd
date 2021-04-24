extends KinematicBody2D


#variables
export var movespeed_x = 20
export var movespeed_y = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# called every physics frame, which is before each drawn frame
func _physics_process(delta):
	var velocity = Vector2()
	var sink = Vector2(0,3)  # sinking vector
	
	velocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * movespeed_x
	velocity.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")) * movespeed_y
	
	var move_vector = (velocity + sink)
	
	velocity = move_and_slide(move_vector)
