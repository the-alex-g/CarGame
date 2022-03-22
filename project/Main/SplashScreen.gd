extends Control

var _can_continue := false


func _input(event:InputEvent)->void:
	if not _can_continue:
		return
	
	if event is InputEventKey:
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Main/Main.tscn")


func _on_AnimationPlayer_animation_finished(_anim_name:String)->void:
	_can_continue = true
