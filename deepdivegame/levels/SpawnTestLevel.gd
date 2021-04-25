extends Node2D

onready var globals = get_node("/root/Globals")
onready var darkness = $Darkness
var Bubble = preload("res://scenes/AirBubble.tscn")
var Flashlight = preload("res://scenes/Flashlight.tscn")
var Feesh = preload("res://scenes/Feesh.tscn")
var Foosh = preload("res://scenes/Foosh.tscn")
var Warning = preload("res://scenes/SnarkWarning.tscn")
var Gloosh = preload("res://scenes/Gloosh.tscn")
var Sploosh = preload("res://scenes/Sploosh.tscn")
var stop_spawns = false
var boss_started = false

var x_bound = 320
# var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	# rng.randomize()  # enable this on release
	# randomize()  # or this one
	$SpawnTimer.connect("timeout",self,"_on_SpawnTimer_timeout")
	$BubbleTimer.connect("timeout", self, "spawn_bubble")
	$FlashlightTimer.connect("timeout", self, "roll_flashlight")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var color_value = 1 - (globals.player["depth"] * .0002)
	var color = Color.from_hsv(0, 0, color_value)
	darkness.set_color(color)
	if globals.player["depth"] > 9940 and not boss_started:
		boss_started = true
		call_runaway()

func call_runaway():
	for object in self.get_children():
		if object.has_method("run_away"):
			object.run_away()

# handles spawning
func _on_SpawnTimer_timeout():
	if not stop_spawns:
		var random_float = randf()
		if globals.player["depth"] < 1000:
			spawn_section1(random_float)
		elif globals.player["depth"] < 3000:
			print("spawning 2")
			spawn_section2(random_float)
		elif globals.player["depth"] < 6000:
			print("spawning 3")
			spawn_section3(random_float)
		elif globals.player["depth"] < 10000 - 60:
			print("spawning 4")
			spawn_section4(random_float)
		else:
			stop_spawns = true
			print("boss area")
	

#	if random_float < 0.2:
#		spawn_snark()
#	elif random_float < 0.4:
#		spawn_feesh(Foosh)
#	elif random_float < 0.6:
#		spawn_feesh(Feesh)
#	elif random_float < 0.8:
#		spawn_gloosh()
#	else:
#		spawn_feesh(Sploosh)

func spawn_section1(randnum):
	if randnum < 0.5:
		spawn_feesh(Foosh)
	else:
		spawn_feesh(Feesh)

func spawn_section2(randnum):
	if randnum < 0.3:
		spawn_feesh(Sploosh)
	elif randnum < 0.6:
		spawn_feesh(Foosh)
	else:
		spawn_feesh(Feesh)
		
func spawn_section3(randnum):
	if randnum < 0.2:
		spawn_feesh(Sploosh)
	elif randnum < 0.4:
		spawn_feesh(Foosh)
	elif randnum < 0.6:
		spawn_gloosh()
	else:
		spawn_feesh(Feesh)

func spawn_section4(randnum):
	if randnum < 0.2:
		spawn_feesh(Sploosh)
	elif randnum < 0.4:
		spawn_feesh(Foosh)
	elif randnum < 0.6:
		spawn_gloosh()
	elif randnum < 0.8:
		spawn_snark()
	else:
		spawn_feesh(Feesh)

func spawn_bubble():
	var new_bubble = Bubble.instance()
	var spawn_area = Vector2(rand_range(10, 310), 250 + globals.player["depth"])
	new_bubble.change_position(spawn_area)
	add_child(new_bubble)


func roll_flashlight():
	var random_float = randf()-.15  # -.2 to .8 value
	var depth = globals.player["depth"]
	var cur_fl_level = globals.powerups["flashlight"]
	var chance = random_float + (depth/10000)/2 - (cur_fl_level/7)*.8  # chance goes up with depth, down with battery
	#print("RF: ", random_float, " -- CHANCE: ", chance)
	if chance > .71: 
		#print("--- FLASHLIGHT SPAWNED!!")
		spawn_flashlight()
	

func spawn_flashlight():
	var new_fl = Flashlight.instance()
	var spawn_area = Vector2(rand_range(50, 320-50), 250 + globals.player["depth"])
	new_fl.change_position(spawn_area)
	#print("SPAWNED AT: ", spawn_area.y/10)
	add_child(new_fl)

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
