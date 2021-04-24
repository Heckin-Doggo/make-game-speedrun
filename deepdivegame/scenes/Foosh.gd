extends Feesh

var state = SWIM
var player
onready var detection_box = $PlayerDetectionBox

enum{
	SWIM,
	TARGET_PLAYER,
	CHARGE
}

func _ready():
	detection_box.connect("area_entered", self, "player_detected")
	detection_box.connect("area_exited", self, "player_lost")

func player_detected(Player):
	print("found player")
	state = TARGET_PLAYER
	player = Player

func player_lost():
	print("lost player")
	if(state == TARGET_PLAYER):
		state = SWIM

func _physics_process(delta):
	match state:
		SWIM:
			move(velocity)
		TARGET_PLAYER:
			velocity = player.position - position
		CHARGE:
			pass

func move(velocity):
	move_and_slide(velocity)
