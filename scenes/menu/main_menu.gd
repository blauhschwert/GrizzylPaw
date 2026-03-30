class_name MainMenu
extends Control

@onready var main_buttons: BoxContainer = $MainButtons
@onready var credits_text: HFlowContainer = $Credits

func _on_quit_button_down() -> void:
	get_tree().quit()


func _on_credits_button_down() -> void:
	main_buttons.hide()
	credits_text.show()


func _on_button_button_down() -> void:
	credits_text.hide()
	main_buttons.show()


func _on_start_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/Game.tscn")
