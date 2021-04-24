extends KinematicBody2D
class_name Feesh

onready var damage_box = $Damagebox
onready var globals = get_node("/root/Globals")
var speed = 1500
var velocity = Vector2.ZERO
var side

func _ready():
	damage_box.connect("body_entered", self, "do_damage")

func _physics_process(delta):
	move_and_slide(velocity * speed * delta)
	if(velocity.x > 0):
		get_node("Sprite").flip_h = true
	else:
		get_node("Sprite").flip_h = false
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

func _on_VisibilityNotifier2D_screen_exited():
	print("despawning")
	queue_free()

func do_damage(body):
	globals.player["oxygen"] -= 5
	if(body.has_method("spawn_bubbles")):
		body.spawn_bubbles(5, 0.1)


