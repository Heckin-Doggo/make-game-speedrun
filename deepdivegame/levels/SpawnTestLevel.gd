extends Node2D

onready var globals = get_node("/root/Globals")
onready var darkness = $Darkness
var Bubble = preload("res://scenes/AirBubble.tscn")
var Feesh = preload("res://scenes/Feesh.tscn")
var Foosh = preload("res://scenes/Foosh.tscn")
var Warning = preload("res://scenes/SnarkWarning.tscn")
var Gloosh = preload("res://scenes/Gloosh.tscn")

var x_bound = 320
# var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	# rng.randomize()  # enable this on release
	# randomize()  # or this one
	$SpawnTimer.connect("timeout",self,"_on_SpawnTimer_timeout")
	$BubbleTimer.connect("timeout", self, "spawn_bubble")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var color_value = 1 - (globals.player["depth"] * .0005)
	var color = Color.from_hsv(0, 0, color_value)
	darkness.set_color(color)


# handles spawning
func _on_SpawnTimer_timeout():
	var random_float = randf()
	
	if random_float < 0.3:
		spawn_snark()
	elif random_float < 0.6:
		spawn_feesh(Foosh)
	else:
		spawn_feesh(Feesh)
	if(random_float < 0.2):
		spawn_gloosh()

func spawn_bubble():
	var new_bubble = Bubble.instance()
	var spawn_area = Vector2(rand_range(10, 310), 250 + globals.player["depth"])
	new_bubble.change_position(spawn_area)
	add_child(new_bubble)

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
	pos_vector.y = round(rand_range(-50  + globals.player["depth"], 250 + globals.player["depth"]))  # ints only muahaha

	new_feesh.change_pos(pos_vector)
	add_child(new_feesh)

func spawn_snark():
	var new_warning = Warning.instance()
	var random_float = randf()
	var warning_spot = Vector2.ZERO
	if random_float < 0.5:
		new_warning.set_side("left")
		warning_spot.x = 40
	else:
		new_warning.set_side("right")
		warning_spot.x = 310
	warning_spot.y = globals.player["depth"]
	new_warning.set_position(warning_spot)
	add_child(new_warning)

func spawn_gloosh():
	var new_gloosh = Gloosh.instance()
	var spawn_position = Vector2.ZERO
	spawn_position.y = globals.player["depth"] + 100
	spawn_position.x = rand_range(10, 310)
	new_gloosh.set_position(spawn_position)
	add_child(new_gloosh)
