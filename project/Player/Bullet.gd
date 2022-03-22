extends KinematicBody2D

const SPEED := 300.0
const COLORS := [Color.blue, Color.red]

var _direction := 0.0
var _player_id := -1

onready var _collision_shape = $CollisionShape2D as CollisionShape2D

func _process(delta:float)->void:
	var collision := move_and_collide(Vector2.RIGHT.rotated(_direction) * SPEED * delta)
	if collision != null:
		var collider := collision.collider
		if collider is Player:
			if collider.player_id != _player_id:
				collider.damage(1)
		queue_free()


func _draw()->void:
	draw_circle(Vector2.ZERO, _collision_shape.shape.radius, COLORS[_player_id])


func setup(player_id, direction, starting_position)->void:
	position = starting_position
	_player_id = player_id
	_direction = direction
