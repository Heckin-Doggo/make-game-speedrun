extends Feesh

var dash_speed = speed * 3
var charge_direction = Vector2.ZERO
var tired = false
var state = SWIM
var player_target
onready var detection_box = $PlayerDetectionBox
onready var dmg_box = $Damagebox

enum{
	SWIM,
	TARGET_PLAYER,
	CHARGE
}

func _ready():
	detection_box.connect("body_entered", self, "player_detected")
	detection_box.connect("body_exited", self, "player_lost")
	dmg_box.connect("body_entered", self, "do_damage")

func player_detected(player):
	print("found player")
	if(tired == false):
		state = TARGET_PLAYER
		player_target = player

func player_lost(player):
	print("lost player")
	if(tired == false):
		state = CHARGE
		charge_direction = (player_target.position - position).normalized()
	player_target = null

func _physics_process(delta):
	match state:
		SWIM:
			if(side == "left"):
				velocity = Vector2(1, 0)
			else:
				velocity = Vector2(-1, 0)
				
		TARGET_PLAYER:
			velocity = (player_target.position - position).normalized()
			
		CHARGE:
			tired = true
			velocity = charge_direction
			speed = dash_speed
	position.y = clamp(position.y, 0, INF)

func do_damage(body):
	globals.player["oxygen"] -= 5
	if(body.has_method("spawn_bubbles")):
		body.spawn_bubbles(5, 0.1)
