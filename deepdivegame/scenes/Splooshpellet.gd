extends RigidBody2D
class_name SplooshPellet

onready var hitbox = $Hitbox
var velocity = Vector2.ZERO

func _ready():
	hitbox.connect("body_entered", self, "hit")

func init(dir, pos, speed):
	position = pos
	linear_velocity = dir.normalized() * speed

func hit(body):
	if body.has_method("take_damage"):
		body.take_damage()
	queue_free()
