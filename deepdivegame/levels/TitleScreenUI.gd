extends Control

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartButton.connect("pressed", self, "send_signal")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func send_signal():
	emit_signal("start_game")
