extends KinematicBody2D
class_name Feesh

onready var vis_notif = $VisibilityNotifier2D
onready var damage_box = $Damagebox
var speed = 1500
var run_speed = speed * 4
var velocity = Vector2.ZERO
var side
var runaway = false

func _ready():
	damage_box.connect("body_entered", self, "do_damage")
	vis_notif.connect("screen_exited", self, "despawn")
	

func _physics_process(delta):
	move_and_slide(velocity * speed * delta)
	flip()
	position.y = clamp(position.y, 0, INF)
	

func init(direction):
	if(direction == "left"):
		velocity.x = 1
		side = direction
	else:
		velocity.x = -1
		side = direction

func change_pos(pos : Vector2):
	position.x = pos.x
	position.y = pos.y

func despawn():
	queue_free()

func do_damage(body):
	if(body.has_method("take_damage")):
		body.take_damage()

func flip():
	if velocity.x > 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false

func run_away():
	runaway = true
	speed = run_speed
	get_node("Damagebox/CollisionShape2D").disabled = true
	get_node("CollisionShape2D").disabled = true
