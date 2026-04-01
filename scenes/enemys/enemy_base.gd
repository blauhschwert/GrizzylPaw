class_name EnemyBase
extends CharacterBody2D

@export var enemy_texture : Array[PackedScene]
@export var player_reference : Player

var speed = randf_range(15, 25)
var is_moving : bool = false

@onready var player = get_node("/root/Game/World00/Player")
@onready var live_bar: LiveBar = $LiveBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemy_sprite = enemy_texture.pick_random().instantiate()
	add_child(enemy_sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_moving == true:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()

func take_damage(amount) -> void:
	live_bar.reduce_health.emit(amount)

func _on_live_bar_health_depleted() -> void:
	queue_free()


func _on_vision_range_body_entered(body: Node2D) -> void:
	if body is Player:
		is_moving = true
