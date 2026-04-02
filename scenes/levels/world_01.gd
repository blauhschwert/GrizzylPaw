extends Node2D

@export var enemy : PackedScene
@export var spawn_pos : Array[Marker2D]

var spawn_addjustment : Array[Vector2] = [
	Vector2(20,-30),
	Vector2(20,-30),
	Vector2(0,30)
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var test_enemy = enemy.instantiate()
	test_enemy.global_position = spawn_pos.pick_random().global_position + spawn_addjustment.pick_random()
	add_child(test_enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/levels/world00.tscn")
