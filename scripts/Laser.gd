extends Node2D

export var length = 40 setget set_length
export var charge_time = 2

onready var beam_charger = $BeamCharger
onready var lazer = $Laser
onready var tween = $Tween
onready var anim_player = $AnimationPlayer

func _ready():
	beam_charger.rect_size.y = length
	yield(get_tree().create_timer(1.0), "timeout")
	anim_player.play("fire")

func fire():
	var width = lazer.rect_size.x
	tween.interpolate_property(lazer, "rect_size", Vector2(width, 0), Vector2(width, length), 0.5,Tween.TRANS_CUBIC, Tween.EASE_OUT) 
	tween.start()
	yield(tween, "tween_completed")
	tween.interpolate_property(lazer, "self_modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT) 
	tween.start()
	
func set_length(value):
	length = value