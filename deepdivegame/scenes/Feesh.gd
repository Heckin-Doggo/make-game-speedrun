extends KinematicBody2D
class_name Feesh

var speed = 40
var velocity = Vector2.ZERO
var side

func _physics_process(delta): 
	move_and_slide(velocity * speed * delta)
	print(velocity)

func init(Side):
	if(side == "left"):
		velocity.x = 1
		get_node("Sprite").flip_h = true
		side = Side
	else:
		velocity.x = -1
		get_node("Sprite").flip_h = false
		side = Side



func change_pos(pos : Vector2):
	position.x = pos.x
	position.y = pos.y

func change_speed(spd : float):
	speed = spd
