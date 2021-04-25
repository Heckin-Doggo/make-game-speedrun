extends Sprite


# Declare member variables here. Examples:
var started = false


# Called when the node enters the scene tree for the first time.
func _ready():
	#bobbin boat.
	while not started:
		position.y += 1
		yield(get_tree().create_timer(2),"timeout")
		position.y += -1
		yield(get_tree().create_timer(2),"timeout")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
