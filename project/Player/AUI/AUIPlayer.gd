class_name AUI
extends KinematicBody2D

signal dead(player)
signal update_health(new_value, player)

const COLORS := [Color.blue, Color.red]
const PATH_TO_BULLET := "res://Player/Bullet.tscn"

export var speed := 200.0
export var player_id := 1

var _poly_data = [] as PoolVector2Array
var _health := 5
var _player_in_range := false
var _can_shoot := true
var _turn_index := 0

onready var _polygon = $CollisionPolygon2D as CollisionPolygon2D
onready var _shoot_position = $ShootPosition as Position2D
onready var _shoot_timer = $ShootCooldownTimer as Timer

func _ready()->void:
	_poly_data = _polygon.polygon
	_get_new_direction()


func _physics_process(delta:float)->void:
	if not _player_in_range:
		rotate(TAU * _turn_index / 90)
	else:
		if _can_shoot:
			_shoot()
	
	var velocity := Vector2.RIGHT
	velocity = velocity.rotated(rotation)
	velocity *= speed * delta
	# warning-ignore:return_value_discarded
	move_and_collide(velocity)


func _draw()->void:
	draw_colored_polygon(_poly_data, COLORS[player_id])


func _is_action_pressed(action_name:String)->bool:
	return Input.is_action_pressed("player_" + str(player_id+1) + "_" + action_name)


func _shoot()->void:
	_can_shoot = false
	var bullet = load(PATH_TO_BULLET).instance() as KinematicBody2D
	bullet.setup(player_id, rotation, _shoot_position.global_position)
	get_parent().add_child(bullet)
	_shoot_timer.start()


func damage(amount:int)->void:
	_health -= amount
	if _health <= 0:
		emit_signal("dead", player_id)
	emit_signal("update_health", _health, player_id)


func _on_Area2D_body_entered(body:PhysicsBody2D)->void:
	if body is Player:
		_player_in_range = true
		_turn_index = 0


func _on_Area2D_body_exited(body:PhysicsBody2D)->void:
	if body is Player:
		_player_in_range = false
		_get_new_direction()


func _get_new_direction()->void:
	match randi()%2:
		0:
			_turn_index = -1
		1:
			_turn_index = 1


func _on_ShootCooldownTimer_timeout()->void:
	_can_shoot = true
