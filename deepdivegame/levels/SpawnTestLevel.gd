extends Node2D

var Feesh = preload("res://scenes/Feesh.tscn")

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
	var feesh : Feesh = Feesh.instance()
	var pos_vector = Vector2()
	
	if random_float < 0.5:
		print("left spawn")
		pos_vector.x = 0
		feesh.init("left")
	else:
		print("right spawn")
		pos_vector.x = x_bound
		feesh.init("right")
	
	
	pos_vector.y = round(rand_range(0,180))  # ints only muahaha
	
	print("Spawning at ", pos_vector)

	feesh.change_pos(pos_vector)
	add_child(feesh)






