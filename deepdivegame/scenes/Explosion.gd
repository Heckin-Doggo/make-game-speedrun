extends Node2D

onready var timer = $Timer
onready var explosion = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", self, "die")
	explosion.connect("body_entered", self, "do_damage")

func do_damage(body):
	if body.has_method("take_damage"):
		body.take_damage()

func set_position(pos):
	position = pos

func die():
	queue_free()
