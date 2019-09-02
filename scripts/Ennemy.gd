extends Node2D

export(bool) var has_idle = true
onready var anim_player = $"AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready():
	if has_idle:
		anim_player.play("idle")