class_name LiveBar
extends Control

signal health_depleted
signal reduce_health(amount)

var max_health : int = 9
var current_health : int = 9 

@onready var progress_bar: ProgressBar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reduce_health.connect(_reduce_health)
	
	progress_bar.max_value = max_health
	progress_bar.value = current_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_health()
	if current_health <= 0:
		health_depleted.emit()

func update_health() -> void:
	$Label.text = str(max_health) + " / " + str(current_health)

func _reduce_health(amount: int) -> void:
	
	current_health -= amount
	progress_bar.value = current_health
	
	
	 
