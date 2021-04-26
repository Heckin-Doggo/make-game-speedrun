extends Node2D

var Shot = preload("res://scenes/Tentacleshot.tscn")
onready var tween = $Tween
var risen = false

func rise(num):
	if not risen:
		$Light2D.enabled = true
		tween.interpolate_property(self, "position",
		position, Vector2(position.x, position.y - 60), 1,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
		tween.start()
		risen = true
		yield(get_tree().create_timer(2),"timeout")
		shoot(num)
		

func lower():
	if risen:
		tween.interpolate_property(self, "position",
		position, Vector2(position.x, position.y + 60), 1,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
		tween.start()
		$Light2D.enabled = false
		risen = false

func shoot(num):
	for x in range(0, num):
		var radians = (2 * PI/10)
		var bullet_num = 1
		var new_shot1 = Shot.instance()
		var new_shot2 = Shot.instance()
		var new_shot3 = Shot.instance()
		var new_shot4 = Shot.instance()
		var new_shot5 = Shot.instance()
		var new_shot6 = Shot.instance()
		var new_shot7 = Shot.instance()
		var new_shot8 = Shot.instance()
		var new_shot9 = Shot.instance()
		var new_shot10 = Shot.instance()
		var shot_list = [new_shot1, new_shot2, new_shot3, new_shot4, new_shot5,
		new_shot6, new_shot7, new_shot8, new_shot9, new_shot10]
		for shot in shot_list:
			var x_distance = cos((radians * bullet_num) + x * PI/4)
			var y_distance = sin((radians * bullet_num) + x * PI/4)
			shot.init(Vector2(x_distance, y_distance), position, 40)
			bullet_num += 1
			get_parent().add_child(shot)
		yield(get_tree().create_timer(0.66),"timeout")
	lower()
