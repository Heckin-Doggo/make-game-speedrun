extends KinematicBody2D
class_name Feesh

var speed = 20.0
var velocity = Vector2.ZERO

func _physics_process(delta):
	move_and_slide(velocity)

func init(side):
	if(side == "left"):
		velocity.x = 1 * speed
		get_node("Sprite").flip_h = true
	else:
		velocity.x = -1 * speed
		get_node("Sprite").flip_h = false



func change_pos(pos : Vector2):
	position.x = pos.x
	position.y = pos.y
