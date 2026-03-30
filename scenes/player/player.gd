class_name Player
extends CharacterBody2D

enum PlayerStates {IDLE, WALK, ATTACK}

const SPEED = 100.0

var direction : Vector2 = Vector2.DOWN
var player_state : PlayerStates = PlayerStates.IDLE

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("move_down"):
		direction = Vector2.DOWN
		player_state = PlayerStates.WALK
	elif Input.is_action_just_pressed("move_up"):
		direction = Vector2.UP
		player_state = PlayerStates.WALK
	elif Input.is_action_just_pressed("move_left"):
		direction = Vector2.LEFT
		player_state = PlayerStates.WALK
	elif Input.is_action_just_pressed("move_right"):
		direction = Vector2.RIGHT
		player_state = PlayerStates.WALK
	else:
		direction = Vector2.ZERO
		player_state = PlayerStates.IDLE
	

func _physics_process(delta: float) -> void:
	play_animation()
	velocity = direction * SPEED
	move_and_slide()

func play_animation() -> void:
	match player_state:
		PlayerStates.IDLE:
			$AnimationPlayer.play("idle")
		PlayerStates.WALK:
			if direction == Vector2.DOWN:
				$AnimationPlayer.play("run_down")
			elif direction == Vector2.LEFT:
				$AnimationPlayer.play("run_left")
			elif direction == Vector2.RIGHT:
				$AnimationPlayer.play("run_right")
			else:
				$AnimationPlayer.play("run_up")
