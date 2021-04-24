extends KinematicBody2D

var direction = Vector2.ZERO
var speed = 20
var velocity = Vector2.ZERO

func _ready():
	velocity = direction * speed

func _physics_process(delta):
	move_and_slide(direction)

