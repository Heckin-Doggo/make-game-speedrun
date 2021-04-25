extends RigidBody2D

# globals
onready var globals = get_node("/root/Globals")

export var flashlight_boost = 7
export var float_speed = .5

var debounce = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$HitBox.connect("body_entered", self, "_on_collect")
	linear_velocity.x = randf()*3


func _physics_process(delta):
	var velocity = Vector2()

	linear_velocity.y = -float_speed

func change_position(new_position):
	position = new_position

func _on_collect(body):
	print("Collided with ", body.name)
	if not debounce and body.name == "Diver":
		debounce = true
		globals.powerups["flashlight"] = clamp(globals.powerups["flashlight"]+flashlight_boost, 0, 7)  # 7 is fl max
		
		$FlashlightSound.play()
		visible = false
		yield($FlashlightSound, "finished")
		queue_free()
