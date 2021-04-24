extends KinematicBody2D

# glboals
onready var globals = get_node("/root/Globals")

#variables
export var movespeed_x = 50
export var movespeed_y = 50
var debounce = false

var screen_size

const Bubble = preload("res://scenes/Bubble.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = true
	screen_size = get_viewport_rect().size
	$BubbleTimer.connect("timeout", self, "_on_BubbleTimer_timeout")
	$OxygenTimer.connect("timeout", self, "_on_OxygenTimer_timeout")
	$FlashLightTimer.connect("timeout", self, "_on_FLTimer_timeout")


# called every physics frame, which is before each drawn frame
func _physics_process(delta):
	var velocity = Vector2()
	var sink = Vector2(0,3)  # sinking vector
	
	velocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * movespeed_x
	velocity.y = (Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")) * movespeed_y
	
	var move_vector = (velocity + sink)
	
	velocity = move_and_slide(move_vector)
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, 10000)
	
	# animation
	var flip = velocity.x < 0
	$AnimatedSprite.flip_h = flip
	# idle animation if not moving
	if velocity.y > 5:
		$AnimatedSprite.animation = "swim_down"
	elif abs(velocity.x) > 0:
		$AnimatedSprite.animation = "swim_h"
	else:
		$AnimatedSprite.animation = "idle"


func _process(delta):
	globals.player["depth"] = round(position.y)  # set it in globals
	if globals.powerups["flashlight"] > 0:
		if $FlashLightTimer.is_stopped():
			$FlashLightTimer.start()
		$Light2D.texture_scale = 3
	else:
		if !$FlashLightTimer.is_stopped():
			$FlashLightTimer.stop()
		$Light2D.texture_scale = 1


func _on_BubbleTimer_timeout():
	spawn_bubbles(3, 0.3)

func _on_OxygenTimer_timeout():
	globals.player["oxygen"] -= 1

func _on_FLTimer_timeout():
	print("FL tick")
	$FlashLightTimer.start()
	globals.powerups["flashlight"] -= 1
	if globals.powerups["flashlight"] < 0:
		$FlashLightTimer.stop()

func spawn_bubbles(bubble_count, bubble_time):
	for i in range(bubble_count):
		var bub = Bubble.instance()
		bub.update_pos(Vector2($Sprite.position.x, $Sprite.position.y-9))  # this makes it local
		add_child(bub)
		yield(get_tree().create_timer(bubble_time),"timeout")  # wait

func take_damage():
	if not debounce:
		debounce = true
		globals.player["oxygen"] -= 5
		spawn_bubbles(5, 0.1)
		yield(get_tree().create_timer(0.5),"timeout")
		debounce = false
