class_name EnemyBase
extends CharacterBody2D

@export var enemy_texture : Array[PackedScene]
@export var player_reference : Player
@export var xp_drop : PackedScene

const FRICTION = 300

var speed = randf_range(15, 25)
var is_moving : bool = false
var is_knocked : bool = false

@onready var player
@onready var live_bar: LiveBar = $LiveBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemy_sprite = enemy_texture.pick_random().instantiate()
	add_child(enemy_sprite)
	
	player = get_tree().get_first_node_in_group("player")
	
	live_bar.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_moving == true:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
	elif is_knocked == true:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		move_and_slide()
		await get_tree().create_timer(0.3).timeout
		is_moving = true

func take_damage(amount) -> void:
	live_bar.reduce_health.emit(amount)
	velocity = Vector2.ONE * 65 * amount / 3
	is_moving = false
	is_knocked = true

func _on_live_bar_health_depleted() -> void:
	var xp_gem_drop = xp_drop.instantiate()
	xp_gem_drop.global_position = global_position
	get_node("/root").add_child(xp_gem_drop)
	queue_free()


func _on_vision_range_body_entered(body: Node2D) -> void:
	if body is Player:
		live_bar.show()
		is_moving = true


func _on_vision_range_body_exited(body: Node2D) -> void:
	if body is Player:
		live_bar.hide()
		is_moving = false
