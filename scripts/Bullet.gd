extends KinematicBody2D

export(Vector2) var velocity = Vector2(0, 0)
export(float) var speed = 100

func _physics_process(delta):
	var vel = velocity.normalized() * speed
	move_and_collide(vel * delta)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
