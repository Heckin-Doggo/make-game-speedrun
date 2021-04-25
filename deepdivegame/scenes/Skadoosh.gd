extends Node2D

onready var tween = $Tween
onready var lure = $Area2D
var appeared = false

func _ready():
	lure.connect("body_entered", self, "appear")

func appear(body):
	if not appeared:
		print("Appearing")
		tween.interpolate_property(self, "position",
		position, Vector2(position.x, position.y - 120), 1,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()
		appeared = true
