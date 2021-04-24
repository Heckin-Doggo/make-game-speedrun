extends RigidBody2D

# globals
onready var globals = get_node("/root/Globals")

# Declare member variables here
export var float_speed = 7
export var amplifier = 10
export var period = 2  # this really shouldnt go above 2. use amplifier instead.

# var anim_steps = [-2,-1,0,1,2,1,0,-1]
var time_since_last_cycle = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _physics_process(delta):
	var velocity = Vector2()
	time_since_last_cycle += delta
	if time_since_last_cycle >= 2*PI:
		time_since_last_cycle -= 2*PI

	linear_velocity.x = 10*sin(2*time_since_last_cycle)
	linear_velocity.y = -float_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
