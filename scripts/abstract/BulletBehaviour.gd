extends Node2D

enum BulletPath { PATH=0, CUSTOM=1 }

export(BulletPath) var pathType = BulletPath.CUSTOM
export(bool) var auto_start = false
export(float) var start_angle = 0
export(float) var angle_step = PI * -0.10
export(float) var rate = 1
export(NodePath) var path

export(PackedScene) var bullet

var angle = 0
var wait_time = 0
var current_time = 0
var playing = false

func _ready():
	angle = start_angle
	playing = auto_start
	wait_time = (1.0 / rate)

func _process(delta):
	if playing:
		current_time += delta
		if current_time >= wait_time:
			shoot()
			current_time = 0

func start():
	playing = true

func stop():
	playing = false

func shoot():
	var b = bullet.instance()
	# we don't care about the radius since the vector is normalized
	b.velocity = polar2cartesian(5, angle).normalized()
	angle += angle_step
	add_child(b)
