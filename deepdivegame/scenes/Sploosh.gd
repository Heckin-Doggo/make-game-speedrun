extends Feesh

var Splooshpellet = preload("res://scenes/Splooshpellet.tscn")
onready var player_detector = $Playerdetector
onready var personal_bubble = $Personalbubble
var state = SWIM
var player_target

enum{
	SWIM,
	SHOOT,
	RUN
}

func _ready():
	player_detector.connect("body_entered", self, "found_player")
	player_detector.connect("body_exited", self, "lose_player")
	personal_bubble.connect("body_entered", self, "run")
	personal_bubble.connect("body_exited", self, "has_room")

func _physics_process(delta):
	match state:
		SWIM:
			if(side == "left"):
				velocity = Vector2(1, 0)
			else:
				velocity = Vector2(-1, 0)
		SHOOT:
			velocity = Vector2.ZERO
			shoot()
		RUN:
			velocity = (player_target.position - position).normalized() * -1

func shoot():
	var new_splooshpellet = Splooshpellet.instance()
	new_splooshpellet.init(player_target.position - position, position, 4000)
	add_child(new_splooshpellet)

func found_player(player):
	print("found player")
	player_target = player
	state = SHOOT

func run(player):
	print("running from player")
	state = RUN

func lose_player(player):
	state = SWIM
	player_target = null
	
func has_room(player):
	state = SHOOT
