extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$PopTimer.connect("timeout", self, "pop")

func update_pos(pos):
	position = pos

func pop():  # hehe bubble go pop
	queue_free()
