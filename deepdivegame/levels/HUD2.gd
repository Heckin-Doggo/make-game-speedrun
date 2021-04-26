extends Control

# Load globals
onready var globals = get_node("/root/Globals")

var death_depth = 0
var boss_threshold = 9830 # where the top of camera goes to.
var last_song = "normal"

# Called when the node enters the scene tree for the first time.
func _ready():
	$DeathPrompt/ButtonNormalRestart.connect("pressed", self, "restart")
	$DeathPrompt/ButtonBossRestart.connect("pressed", self, "boss_restart")


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
		
	# Show death prompt and decide if boss prompt should show too.
	if globals.player["alive"] == false:
		change_death_depth(globals.player["depth"])
		$DeathPrompt.show()
		if death_depth > boss_threshold:
			print("oh cool you died in boss")
			$DeathPrompt/ButtonBossRestart.show()
	else:
		$DeathPrompt.hide()
		
	# Show the prompt.
	if globals.music != last_song:
		if globals.music == "sting":
			show_boss_message()
		last_song = globals.music

func restart():
	globals.player["oxygen"] = 68
	globals.player["alive"] = true
	globals.music = "normal"
	$DeathPrompt/ButtonBossRestart.hide()
	$DeathPrompt.hide()
	get_tree().reload_current_scene()
	
func boss_restart():
	globals.boss_restart = true
	restart()

func change_death_depth(depth):  # makes sure this only updates once.
	if death_depth == 0:
		death_depth = depth
		
func show_boss_message():
	$BossMessage.show()
	yield(get_tree().create_timer(5), "timeout")
	$BossMessage.hide()
