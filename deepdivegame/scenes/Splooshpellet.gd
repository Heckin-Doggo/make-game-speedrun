extends RigidBody2D

signal bullet_hit

var velocity = Vector2.ZERO

func init(vel, pos, speed):
	velocity = vel.normalized() * speed
	position = pos

func _ready():
	set_linear_velocity(velocity)
	self.connect("body_entered", self, "_onSplooshpellet_body_entered")

func _on_Splooshpellet_body_entered(object):
	if(object.has_method("take_damage")):
		object.take_damage()

func _on_Despawntimer_timeout():
	queue_free()
