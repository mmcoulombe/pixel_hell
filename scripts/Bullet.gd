extends KinematicBody2D

export(Vector2) var velocity = Vector2(0, 0)
export(float) var speed = 100
export(bool) var auto_start = true

var shouldMove;

func _ready():
	shouldMove = auto_start

func _physics_process(delta):
	if shouldMove:
		var vel = velocity.normalized() * speed
		move_and_collide(vel * delta)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func activate():
	shouldMove = true
