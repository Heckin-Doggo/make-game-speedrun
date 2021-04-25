extends Node2D

onready var globals = get_node("/root/Globals")
var Sploosh = preload("res://scenes/Sploosh.tscn")
var Warning = preload("res://scenes/SnarkWarning.tscn")
onready var tween = $Tween
onready var lure = $Area2D
var appeared = false

func _ready():
	lure.connect("body_entered", self, "appear")

func appear(body):
	if not appeared:
		print("Appearing")
		tween.interpolate_property(self, "position",
		position, Vector2(position.x, position.y - 120), 1,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()
		appeared = true
		yield(get_tree().create_timer(1),"timeout")
		snark_attack()
		yield(get_tree().create_timer(5),"timeout")
		summon_sploosh()

func snark_attack():
	for x in range(0, 6):
		var snark1 = Warning.instance()
		var snark2 = Warning.instance()
		var warning_spot = Vector2.ZERO
		snark1.set_side("left")
		snark2.set_side("right")
		
		snark1.set_position(Vector2(40, 10000 - x*30))
		snark2.set_position(Vector2(310, 10000 - x*30))
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
