extends Gloosh

var Explosion = preload("res://scenes/Explosion.tscn")
onready var explosion_timer = $Timer

export var tick_delay = 1.95  # seconds before first tick.
var time = 0
var blipped = true

func _physics_process(delta):
	position.y = clamp(position.y, 10000-150, 10000-30)
	if linear_velocity.x > 0:
		$SpriteExplode.flip_h = true
	else:
		$SpriteExplode.flip_h = false

func _process(delta):
	time += delta
	if time >= tick_delay:
		time -= tick_delay
		tick_delay = tick_delay * .8
		if blipped:
			$SpriteExplode.show()
		else:
			$SpriteExplode.hide()
		$TickSound.play()
		blipped = !blipped


func _ready():
	explosion_timer.connect("timeout", self, "explode")
	swim_speed = swim_speed * 0.5
	
func explode():
	var new_explosion = Explosion.instance()
	new_explosion.set_position(position)
	get_parent().add_child(new_explosion)
	queue_free()
