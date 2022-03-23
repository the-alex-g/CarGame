extends Control

const TWO_PLAYER_MESSAGE := "This is a two-player game. The blue player uses WASD, the red player uses the arrow keys.\nW or up arrow shoots, A and D or the left and right arrow keys turn. You are always moving forward.\n\nHit the other player with your bullets to win!"
const ONE_PLAYER_MESSAGE := "You are the blue player. W shoots, A turns left, and D turns right.\nThe AUI (Artifical UnIntelligence) will try to shoot you.\n\nGood luck!"

var _two_player := true

onready var _one_player_box = $VBoxContainer/OnePlayerCheck as CheckBox
onready var _two_player_box = $VBoxContainer/TwoPlayerCheck as CheckBox
onready var _message = $Instruct as Label

func _on_TwoPlayerCheck_toggled(button_pressed:bool)->void:
	if button_pressed:
		_two_player = true
		_one_player_box.pressed = false
		_message.text = TWO_PLAYER_MESSAGE


func _on_OnePlayerCheck_toggled(button_pressed:bool)->void:
	if button_pressed:
		_two_player = false
		_two_player_box.pressed = false
		_message.text = ONE_PLAYER_MESSAGE


func _on_Cont_pressed()->void:
	if _two_player:
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Main/Main.tscn")
	else:
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Main/AUI/AUIMain.tscn")
