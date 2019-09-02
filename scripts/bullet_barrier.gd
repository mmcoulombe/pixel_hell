extends Node2D

export(float) var rate = 6
export(int) var amount = 1
export(PackedScene) var bullet

var size = 400
var bounds = 300
var margin = 20

onready var anim_player = $"AnimationPlayer"
onready var shoot_timer = $"Shoot"

func _ready():
	shoot_timer.wait_time = (1.0 / rate)
	yield(get_tree().create_timer(1.0), "timeout")
	anim_player.play("start")

func shoot():
	randomize()
	var d = 1 if randf() > 0.5 else -1
	var b = bullet.instance()
	b.position.x = d * bounds
	randomize()
	b.position.y = rand_range(-size + margin, -margin)

	# we don't care about the radius since the vector is normalized
	b.velocity = Vector2(d * -1, 0)
	add_child(b)

func _on_Shoot_timeout():
	for i in range(amount):
		shoot()
