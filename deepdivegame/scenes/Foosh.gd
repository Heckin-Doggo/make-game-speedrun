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
	detection_box.connect("body_entered", self, "player_detected")
	detection_box.connect("body_exited", self, "player_lost")

func player_detected(Player):
	print("found player")
	state = TARGET_PLAYER
	player = Player

func player_lost(Player):
	print("lost player")
	player = null
	if(state == TARGET_PLAYER):
		state = SWIM

func _physics_process(delta):
	match state:
		SWIM:
			if(side == "left"):
				velocity = Vector2(1, 0)
			else:
				velocity = Vector2(-1, 0)
				
		TARGET_PLAYER:
			velocity = (player.position - position).normalized()
			
		CHARGE:
			pass

