extends Node2D

export(float) var start_angle = 0
export(float) var angle_step = PI * -0.10
export(float) var rate = 1

export(PackedScene) var bullet

var angle = 0

onready var shoot_countdown = $ShootTimer

func _ready():
	angle = start_angle
	shoot_countdown.wait_time = (1.0 / rate)

func start():
	shoot_countdown.start((1.0 / rate))

func stop():
	shoot_countdown.stop()

func shoot():
	var b = bullet.instance()
	# we don't care about the radius since the vector is normalized
	b.velocity = polar2cartesian(5, angle).normalized()
	angle += angle_step
	add_child(b)

func _on_ShootTimer_timeout():
	shoot()
