extends Node2D

onready var globals = get_node("/root/Globals")
var Sploosh = preload("res://scenes/Sploosh.tscn")
var Warning = preload("res://scenes/SnarkWarning.tscn")
var Kaboosh = preload("res://scenes/Kaboosh.tscn")
onready var tentacle1 = get_parent().get_node_or_null("Tentacle")
onready var tentacle2 = get_parent().get_node_or_null("Tentacle2")
onready var tween = $Tween
onready var lure = $Area2D
var appeared = false
var health = 6

onready var top_right_eye = $TopRightEye
onready var top_left_eye = $TopLeftEye
onready var mid_right_eye = $MidRightEye
onready var mid_left_eye = $MidLeftEye
onready var bot_right_eye = $BotRightEye
onready var bot_left_eye = $BotLeftEye

func _ready():
	lure.connect("body_entered", self, "appear")
	top_right_eye.connect("area_entered", self, "lose_top_right")
	top_left_eye.connect("area_entered", self, "lose_top_left")
	mid_right_eye.connect("area_entered", self, "lose_mid_right")
	mid_left_eye.connect("area_entered", self, "lose_mid_left")
	bot_right_eye.connect("area_entered", self, "lose_bot_right")
	bot_left_eye.connect("area_entered", self, "lose_bot_left")

func _process(delta):
	if health == 0:
		queue_free()

func appear(body):
	if not appeared:
		# Change Music
		globals.music = "sting"
		tween.interpolate_property(self, "position",
		position, Vector2(position.x, position.y - 120), 1,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
		tween.start()
		appeared = true
		attack_cycle()

func attack_cycle():
	var cycle = true
	while true:
		if cycle:
			snark_attack_walls(4)
			yield(get_tree().create_timer(5),"timeout")
			tentacle1.rise(5)
			tentacle2.rise(5)
			summon_sploosh()
			yield(get_tree().create_timer(10),"timeout")
			get_parent().call_runaway()
			snark_attack_wave("bottom")
			yield(get_tree().create_timer(5),"timeout")
			tentacle1.rise(15)
			get_parent().spawn_gloosh(Kaboosh)
			yield(get_tree().create_timer(15),"timeout")
			cycle = false
		else:
			cycle = true
			snark_attack_wave("top")
			yield(get_tree().create_timer(3),"timeout")
			snark_attack_wave("bottom")
			yield(get_tree().create_timer(3),"timeout")
			snark_attack_walls(2)
			yield(get_tree().create_timer(5),"timeout")
			tentacle2.rise(15)
			get_parent().spawn_gloosh(Kaboosh)
			yield(get_tree().create_timer(15),"timeout")

func snark_attack_walls(wall_count):
	for x in range(0, wall_count):
		var snark1 = Warning.instance()
		var snark2 = Warning.instance()
		var snark3 = Warning.instance()
		var snark4 = Warning.instance()
		var snark5 = Warning.instance()
		var snark6 = Warning.instance()
		var snark_list = [snark1, snark2, snark3, snark4, snark5, snark6]
		var start = 10000
		if x % 2 == 0:
			for snark in snark_list:
				snark.set_side("left")
				snark.set_position(Vector2(40, start))
				start = start - 40
				get_parent().add_child(snark)
		elif x % 2 == 1:
			start = start - 20
			for snark in snark_list:
				snark.set_side("right")
				snark.set_position(Vector2(310, start))
				start = start - 40
				get_parent().add_child(snark)
		yield(get_tree().create_timer(0.8),"timeout")

func snark_attack_wave(direction):
	for x in range(0, 6):
		var snark1 = Warning.instance()
		var snark2 = Warning.instance()
		var warning_spot = Vector2.ZERO
		snark1.set_side("left")
		snark2.set_side("right")
		if direction == "bottom":
			snark1.set_position(Vector2(40, 10000 - x*30))
			snark2.set_position(Vector2(310, 10000 - x*30))
		else:
			snark1.set_position(Vector2(40, 9820 + x*30))
			snark2.set_position(Vector2(310, 9820 + x*30))
		get_parent().add_child(snark1)
		get_parent().add_child(snark2)
		yield(get_tree().create_timer(0.5),"timeout")

func summon_sploosh():
	var new_sploosh1 = Sploosh.instance()
	var new_sploosh2 = Sploosh.instance()
	new_sploosh1.init("left")
	new_sploosh2.init("right")
	new_sploosh1.change_pos(Vector2(0, globals.player["depth"]))
	new_sploosh2.change_pos(Vector2(320, globals.player["depth"]))
	get_parent().add_child(new_sploosh1)
	get_parent().add_child(new_sploosh2)

func lose_top_right(body):
	top_right_eye.get_child(0).disabled = true
	$TopRightEye2.visible = true
	health -= 1

func lose_top_left(body):
	top_left_eye.get_child(0).disabled = true
	$TopLeftEye2.visible = true
	health -= 1

func lose_mid_right(body):
	mid_right_eye.get_child(0).disabled = true
	$MidRightEye2.visible = true
	health -= 1

func lose_mid_left(body):
	mid_left_eye.get_child(0).disabled = true
	$MidLeftEye2.visible = true
	health -= 1

func lose_bot_right(body):
	bot_right_eye.get_child(0).disabled = true
	$BotRightEye2.visible = true
	health -= 1

func lose_bot_left(body):
	bot_left_eye.get_child(0).disabled = true
	$BotLeftEye2.visible = true
	health -= 1

