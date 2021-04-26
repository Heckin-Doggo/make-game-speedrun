extends Feesh

func _ready():
	speed = 10000
	if side == "left":
		$eye.offset.x = 8

