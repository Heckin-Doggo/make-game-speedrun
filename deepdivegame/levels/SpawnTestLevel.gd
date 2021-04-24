extends Node2D

onready var globals = get_node("/root/Globals")
var Feesh = preload("res://scenes/Feesh.tscn")
var Foosh = preload("res://scenes/Foosh.tscn")

var x_bound = 320
# var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	# rng.randomize()  # enable this on release
	# randomize()  # or this one
	$SpawnTimer.connect("timeout",self,"_on_SpawnTimer_timeout")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# handles spawning
func _on_SpawnTimer_timeout():
	var random_float = randf()
	
	if random_float < 0.5:
		spawn_feesh(Feesh)
	else:
		spawn_feesh(Foosh)

func spawn_feesh(feesh_type):
	var random_float = randf()
	var new_feesh : Feesh = feesh_type.instance()
	var pos_vector = Vector2()
	
	if random_float < 0.5:
		pos_vector.x = 0
		new_feesh.init("left")
	else:
		pos_vector.x = x_bound
		new_feesh.init("right")
	
	#spawns fish at players depth
	pos_vector.y = round(rand_range(0  + globals.player["depth"], 250 + globals.player["depth"]))  # ints only muahaha

	new_feesh.change_pos(pos_vector)
	add_child(new_feesh)
