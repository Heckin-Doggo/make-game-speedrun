extends KinematicBody2D
class_name Feesh

var speed = 2000
var velocity = Vector2.ZERO
var side

func _physics_process(delta):
	move_and_slide(velocity * speed * delta)
	if(velocity.x > 0):
		get_node("Sprite").flip_h = true
	else:
		get_node("Sprite").flip_h = false

func init(Side):
	if(side == "left"):
		velocity.x = 1
		side = Side
	else:
		velocity.x = -1
		side = Side

func change_pos(pos : Vector2):
	position.x = pos.x
	position.y = pos.y
