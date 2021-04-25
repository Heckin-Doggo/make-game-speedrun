extends RigidBody2D
class_name Gloosh

onready var vis_notif = $VisibilityNotifier2D
var swim_speed

func _ready():
	vis_notif.connect("screen_exited", self, "despawn")
	swim_speed = (0.5 - randf()) * 5

func _physics_process(delta):
	if linear_velocity.x > 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	linear_velocity.x += swim_speed

func set_position(new_position):
	position = new_position

func despawn():
	print("despawning")
	queue_free()
