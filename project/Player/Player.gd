class_name Player
extends KinematicBody2D

signal dead(player)
signal update_health(new_value, player)

const COLORS := [Color.blue, Color.red]
const PATH_TO_BULLET := "res://Player/Bullet.tscn"

export var speed := 200.0
export var player_id := 1

var _poly_data = [] as PoolVector2Array
var _health := 5

onready var _polygon = $CollisionPolygon2D as CollisionPolygon2D
onready var _shoot_position = $ShootPosition as Position2D

func _ready()->void:
	_poly_data = _polygon.polygon


func _physics_process(delta:float)->void:
	if _is_action_pressed("right"):
		rotate(TAU / 80)
	if _is_action_pressed("left"):
		rotate(-TAU / 80)
	if Input.is_action_just_pressed("player_" + str(player_id+1) + "_shoot"):
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
	var bullet = load(PATH_TO_BULLET).instance() as KinematicBody2D
	bullet.setup(player_id, rotation, _shoot_position.global_position)
	get_parent().add_child(bullet)


func damage(amount:int)->void:
	_health -= amount
	if _health <= 0:
		emit_signal("dead", player_id)
	emit_signal("update_health", _health, player_id)
