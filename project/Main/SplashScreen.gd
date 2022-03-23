extends Control

var _two_player := true

onready var _one_player_box = $VBoxContainer/OnePlayerCheck as CheckBox
onready var _two_player_box = $VBoxContainer/TwoPlayerCheck as CheckBox

func _on_TwoPlayerCheck_toggled(button_pressed:bool)->void:
	if button_pressed:
		_two_player = true
		_one_player_box.pressed = false


func _on_OnePlayerCheck_toggled(button_pressed:bool)->void:
	if button_pressed:
		_two_player = false
		_two_player_box.pressed = false


func _on_Cont_pressed()->void:
	if _two_player:
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Main/Main.tscn")
	else:
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Main/AUI/AUIMain.tscn")
