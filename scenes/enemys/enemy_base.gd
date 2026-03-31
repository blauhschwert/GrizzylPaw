extends Node2D

@export var enemy_texture : Array[PackedScene]
@export var player_reference : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemy_sprite = enemy_texture.pick_random().instantiate()
	add_child(enemy_sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
