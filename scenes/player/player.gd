class_name Player
extends CharacterBody2D

enum PlayerStates {IDLE, WALK, ATTACK}

const SPEED = 100.0

var input_vector : = Vector2.ZERO

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback
@onready var bear_punch: Area2D = $BearPunch

func _physics_process(delta: float) -> void:
	
	var state = playback.get_current_node()
	
	match state:
		"MoveState":
			move_state()
		
		"AttackState":
			bear_punch.show()

func move_state() -> void:
	input_vector = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if input_vector != Vector2.ZERO:
		var direction_vector : = Vector2(input_vector.x, -input_vector.y)
		update_blend_position(direction_vector)
			
	if Input.is_action_just_pressed("attack"):
		playback.travel("AttackState")
			
	velocity = input_vector * SPEED
			
	move_and_slide()


func update_blend_position(direction_vector : Vector2) -> void:
		animation_tree.set("parameters/StateMachine/MoveState/RunState/blend_position",direction_vector)
		animation_tree.set("parameters/StateMachine/MoveState/StandState/blend_position",direction_vector)
		animation_tree.set("parameters/StateMachine/AttackState/blend_position",direction_vector)


func _on_bear_punch_body_entered(body: Node2D) -> void:
	print(body.name)
