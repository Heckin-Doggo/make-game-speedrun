extends Node2D

var Shot = preload("res://scenes/Tentacleshot.tscn")
onready var tween = $Tween
var risen = false

func rise(num, num_of_bullets):
	if not risen:
		$Light2D.enabled = true
		tween.interpolate_property(self, "position",
		position, Vector2(position.x, position.y - 60), 1,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
		tween.start()
		risen = true
		yield(get_tree().create_timer(2),"timeout")
		shoot(num, num_of_bullets)
		

func lower():
	if risen:
		tween.interpolate_property(self, "position",
		position, Vector2(position.x, position.y + 60), 1,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
		tween.start()
		$Light2D.enabled = false
		risen = false

func shoot(num, num_of_bullets):
	for x in range(0, num):
		var radians = (2 * PI/num_of_bullets)
		var bullet_num = 1
		var shot_list = []
		for y in range(0, num_of_bullets):
			var new_shot = Shot.instance()
			shot_list.append(new_shot)
		for shot in shot_list:
			var x_distance = cos((radians * bullet_num) + x * PI/num_of_bullets)
			var y_distance = sin((radians * bullet_num) + x * PI/num_of_bullets)
			shot.init(Vector2(x_distance, y_distance), position, 40)
			bullet_num += 1
			get_parent().add_child(shot)
		yield(get_tree().create_timer(0.66),"timeout")
	lower()
