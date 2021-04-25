extends Gloosh

var Explosion = preload("res://scenes/Explosion.tscn")
onready var explosion_timer = $Timer

func _ready():
	explosion_timer.connect("timeout", self, "explode")
	
func explode():
	var new_explosion = Explosion.instance()
	new_explosion.set_position(position)
	get_parent().add_child(new_explosion)
	queue_free()
