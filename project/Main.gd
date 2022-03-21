extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_dead(player:int)->void:
	match player:
		1:
			$Label.text = "Blue player wins!"
		0:
			$Label.text = "Red player wins!"
	yield(get_tree().create_timer(2.0), 'timeout')
	get_tree().change_scene("res://Main.tscn")
