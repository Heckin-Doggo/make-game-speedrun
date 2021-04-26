extends Node2D


# Declare member variables here. Examples:
var started = false
var ticker = 0.0
var boat_y = 1
var delay = 60.0/70.0

onready var Diver = $Boat/Diver
onready var DiverAnim = $Boat/Diver/Anim


# Called when the node enters the scene tree for the first time.
func _ready():
	$TitleScreenUI.connect("start_game", self, "start_game")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ticker += delta
	# print(ticker)
	if not started or started:
		if ticker > delay:
			ticker -= delay
			boat_y = -boat_y
			$Boat.position.y += boat_y

func start_game():
	if not started:
		print("Game starting!")
		started = true
		
		#animation
		
		DiverAnim.animation = "jump"  # ready for jump
		yield(get_tree().create_timer(0.5),"timeout")
		DiverAnim.frame = 1  # in the air
		# enable physics
		Diver.gravity_scale = .5
		Diver.linear_velocity = Vector2(5,-45)
		
		yield(get_tree().create_timer(1),"timeout")
		DiverAnim.frame = 2  # diving
		yield(get_tree().create_timer(1),"timeout")
		
		$Splash.play()
		yield($Splash, "finished")
		
		
		# yield(get_tree().create_timer(3), "timeout")
		get_tree().change_scene("res://levels/SpawnTestLevel.tscn")
