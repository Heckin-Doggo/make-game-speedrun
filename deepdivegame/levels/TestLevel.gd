extends Node2D

var rng = RandomNumberGenerator.new()
var screen_size
const Feesh = preload("res://scenes/Feesh.tscn")

func _ready():
	$SpawnTimer.connect("timeout", self, "spawn_fish")
	screen_size = get_viewport_rect().size

func spawn_fish():
	var feesh = Feesh.instance()
	var spawn_data = Vector2(rng.randi_range(-1, 1), rng.randi_range(0, screen_size.y)) 
	feesh.init(spawn_data)
	add_child(feesh)
