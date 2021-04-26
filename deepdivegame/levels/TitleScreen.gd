extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TitleScreenUI.connect("start_game", self, "start_game")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start_game():
	print("Game starting!")
	get_tree().change_scene("res://levels/SpawnTestLevel.tscn")
