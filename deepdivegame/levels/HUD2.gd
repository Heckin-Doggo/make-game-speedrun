extends Control

# Load globals
onready var globals = get_node("/root/Globals")


# Called when the node enters the scene tree for the first time.
func _ready():
#	for i in range(7,-1,-1):
#		print(i)
#		globals.powerups["flashlight"] = i
#		yield(get_tree().create_timer(1), "timeout")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$OxygenDisplay/FillBar.rect_size.y = clamp(globals.player["oxygen"],0,68)
	$DepthGauge/Label.text = str(floor(globals.player["depth"]/10))
	
	var flashlight_power = globals.powerups["flashlight"]
	if flashlight_power > 0:
		# print("power: ", flashlight_power)
		$FlashlightIndicator.visible = true
		$FlashlightIndicator/Batteries.rect_size.y = 8 * globals.powerups["flashlight"]
	else:
		$FlashlightIndicator.visible = false
