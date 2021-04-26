extends Node2D


# Declare member variables here. Examples:
var started = false
var ticker = 0.0
var boat_y = 1
var delay = 60.0/70.0


# Called when the node enters the scene tree for the first time.
func _ready():
	$TitleScreenUI.connect("start_game", self, "start_game")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ticker += delta
	# print(ticker)
	if not started:
		if ticker > delay:
			ticker -= delay
			boat_y = -boat_y
			$Boat.position.y += boat_y

func start_game():
	print("Game starting!")
	started = true
	# yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene("res://levels/SpawnTestLevel.tscn")
