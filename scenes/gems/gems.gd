class_name XP_Gem
extends Node2D

enum XP_Gem_Status {NONE, BASE, SUPER, EXTREME}

@export var xp_gems : Array[PackedScene]

var xp_gem : XP_Gem_Status = XP_Gem_Status.NONE
var xp_gem_texture = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_xp_gem(XP_Gem_Status.BASE)
	set_xp_texture()
	add_child(xp_gem_texture)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_xp_gem(p_xp_gem : XP_Gem_Status) -> void:
	xp_gem = p_xp_gem

func set_xp_texture() -> void:
	match xp_gem:
		XP_Gem_Status.NONE:
			xp_gem_texture = null
		XP_Gem_Status.BASE:
			xp_gem_texture = xp_gems[0].instantiate()
		XP_Gem_Status.SUPER:
			xp_gem_texture = xp_gems[1].instantiate()
		XP_Gem_Status.EXTREME:
			xp_gem_texture = xp_gems[2].instantiate()
		_:
			xp_gem_texture = null
