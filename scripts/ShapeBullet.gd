extends Node2D

export(Shape2D) var shape
export(PackedScene) var bullet
export(int) var nb_bullet = 4

var bullet_list = []

func _ready():
	set_bullet_position()

func set_bullet_position():
	match shape.get_class():
		"RectangleShape2D":
			positionate_around_rectangle()
		"CircleShape2D":
			positionate_around_circle()
		"ConvexPolygon2DShape":
			positionate_from_points((shape as  ConvexPolygonShape2D).points)
		_:
			push_warning("ShapeBullet: Shape2D not supported")

func positionate_from_points(points):
	var perimeter = get_shape_perimeter(points)
	var spacing = perimeter / nb_bullet
	
	
	
	pass

func get_shape_perimeter(points):
	var length = 0
	for v in points:
		length += v.length()
	return length

func positionate_around_circle():
	var current_step = 0
	var step_rad = deg2rad(360 / nb_bullet)
	var radius = (shape as CircleShape2D).radius
	# miss support for remaining (5 point instead of 4 etc ...)
	for i in range(nb_bullet):
		var b = bullet.instance()
		var pos = polar2cartesian(radius, current_step)
		b.position = pos
		b.velocity = pos.normalized()
		b.auto_start = false
		current_step += step_rad
		bullet_list.append(b)
		add_child(b)

func positionate_around_rectangle():
	var rect_bounds = [Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0), Vector2(0, -1)]
	var extents = (shape as RectangleShape2D).extents
	var bullet_per_edge = floor(nb_bullet / 4.0)
	var remain = nb_bullet % 4
	for edge in rect_bounds:
		var rev = Vector2(edge.y, edge.x)
		var wide = rev * extents * 2
		var spacing = wide / (bullet_per_edge + 1)

		for i in range(1, bullet_per_edge + 1):
			var b = bullet.instance()
	
			b.auto_start = false
			b.position = edge * extents - (wide * 0.5) + (spacing * i)
			b.velocity = edge.normalized()
			bullet_list.append(b)
			add_child(b)

func release_bullet():
	for b in bullet_list:
		b.activate()
	bullet_list.clear()

func reload():
	set_bullet_position()

func _on_Button_pressed():
	release_bullet()


func _on_Button2_pressed():
	reload()
