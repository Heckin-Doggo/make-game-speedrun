extends Node2D

var Snark = preload("res://scenes/Snark.tscn")
var side

func _ready():
	$Timer.connect("timeout", self, "spawn_snark")
	$Timer.start()

func spawn_snark():
	print("Spawning Snark!")
	var new_snark = Snark.instance()
	new_snark.init(side)
	new_snark.change_pos(position)
	get_parent().add_child(new_snark)
	queue_free()

func set_side(spawn_side):
	side = spawn_side

func set_position(spawn_position):
	position = spawn_position
