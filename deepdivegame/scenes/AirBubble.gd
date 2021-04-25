extends RigidBody2D

# globals
onready var globals = get_node("/root/Globals")

# packed scenes
const Bubble = preload("res://scenes/Bubble.tscn")

# Declare member variables here
export var float_speed = 32
export var amplifier = 10
export var period = 2  # this really shouldnt go above 2. use amplifier instead.

export var oxygen_boost = 20

# var anim_steps = [-2,-1,0,1,2,1,0,-1]
var time_since_last_cycle = 0
var debounce = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$HitBox.connect("body_entered", self, "_on_bubble_pop")


func _physics_process(delta):
	var velocity = Vector2()
	time_since_last_cycle += delta
	if time_since_last_cycle >= 2*PI:
		time_since_last_cycle -= 2*PI

	linear_velocity.x = 10*sin(2*time_since_last_cycle)
	linear_velocity.y = -float_speed

func change_position(new_position):
	position = new_position

func _on_bubble_pop(body):
	#print("Collided with ", body.name)
	if not debounce and body.name == "Diver":
		debounce = true
		globals.player["oxygen"] = clamp(globals.player["oxygen"]+oxygen_boost, 20, 68)  # 68 is o2 tank size
		
		# bubble effect
		for i in range(5):
			var bub = Bubble.instance()
			bub.update_pos(Vector2($Sprite.position.x+randf(), $Sprite.position.y-9))  # this makes it local
			body.call_deferred("add_child", bub)
			yield(get_tree().create_timer(0.01),"timeout")  # wait
		
		$BubblePop.play()
		visible = false
		yield($BubblePop, "finished")
		queue_free()
