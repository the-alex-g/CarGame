extends Node2D

signal update_player_health(new_value, player_id)
signal game_over(loser_id)

onready var _game_over_timer = $GameOverTimer as Timer

func _on_Player_dead(player:int)->void:
	emit_signal("game_over", player)
	_game_over_timer.start()


func _on_Player_update_health(new_value:int, player:int)->void:
	emit_signal("update_player_health", new_value, player)


func _on_GameOverTimer_timeout()->void:
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Main/Main.tscn")
