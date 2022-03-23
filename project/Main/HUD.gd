extends CanvasLayer

var _game_over := false

onready var _player_1_health = $Player1Health as ProgressBar
onready var _player_2_health = $Player2Health as ProgressBar
onready var _game_over_label = $GameOverLabel as Label


func _on_Main_update_player_health(new_value, player_id)->void:
	if player_id == 0:
		_player_1_health.value = new_value
	else:
		_player_2_health.value = new_value


func _on_Main_game_over(loser_id)->void:
	if _game_over:
		return
	
	if loser_id == 0:
		_game_over_label.text = "Red player wins!"
	else:
		_game_over_label.text = "Blue player wins!"
	
	_game_over = true
