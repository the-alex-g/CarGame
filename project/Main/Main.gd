extends Node2D

signal update_player_health(new_value, player_id)
signal game_over(loser_id)


func _on_Player_dead(player:int)->void:
	emit_signal("game_over", player)
	yield(get_tree().create_timer(2.0), 'timeout')
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Main/Main.tscn")


func _on_Player_update_health(new_value:int, player:int)->void:
	emit_signal("update_player_health", new_value, player)
