extends Timer

onready var timer = $Timer
onready var explosion = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect()

func do_damage(body):
	if body.has_method("take_damage"):
		body.take_damage()

func die():
	queue_free()
