extends Gloosh

var Explosion = preload("res://scenes/Explosion.tscn")
onready var explosion_timer = $Timer

func _physics_process(delta):
	position.y = clamp(position.y, 10000-150, 10000-30)

func _ready():
	explosion_timer.connect("timeout", self, "explode")
	swim_speed = swim_speed * 0.5
	
func explode():
	var new_explosion = Explosion.instance()
	new_explosion.set_position(position)
	get_parent().add_child(new_explosion)
	queue_free()
