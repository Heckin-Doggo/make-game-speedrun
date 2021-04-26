extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print(convert_to_time(45.41))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func convert_to_time(time):
	var minutes = int(floor(time)) / 60
	var seconds = int(floor(time)) % 60
	if seconds <= 9:
		seconds = "0"+str(seconds)
	return (str(minutes) + ":" + str(seconds))
