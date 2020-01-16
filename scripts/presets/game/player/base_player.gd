extends KinematicBody2D
class_name BasePlayer

export var speed: = Vector2(900.0, 1200.0)
export var gravity: = 1600.0
export var life: = 100

var _velocity: = Vector2.ZERO
var flipped: = false

const FLOOR_NORMAL: = Vector2.UP

export var choosed_gun: = 'machine_gun'

var left: = 0.0
var right: = 0.0
var top: = 0.0
var allow_shoot

onready var guns = {
  'machine_gun': preload('res://presets/game/guns/machine_gun.tscn'),
  'saw_gun': preload('res://presets/game/guns/saw_gun.tscn'),
  'shot_gun': preload('res://presets/game/guns/shot_gun.tscn'),
  'plasma_gun': preload('res://presets/game/guns/plasma_gun.tscn')
}

func _ready():
  var current_gun = guns[choosed_gun].instance()
  current_gun.active_enemy_trigger()
  $weapon_container.add_child(current_gun)

func change_gun(gun_name: String) -> void:
  choosed_gun = gun_name
  for weapon in $weapon_container.get_children():
    weapon.queue_free()
  var current_gun = guns[gun_name].instance()
  current_gun.active_enemy_trigger()
  $weapon_container.add_child(current_gun)

func _on_input_interface_action_detected(action, params):
  if action == 'move_left':
    left = params['strength']
  if action == 'move_right':
    right = params['strength']
  if action == 'jump':
    top = params['strength']
  if action == 'shoot':
    allow_shoot = params['allow']
  if action == 'death':
    queue_free()

func _physics_process(delta: float) -> void:
  _velocity.y += gravity * delta
  var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
  var direction: = get_direction()
  if (_velocity.x > 0 and flipped) or (_velocity.x < 0 and !flipped):
    turn_around()
  _velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
  var snap: Vector2 = Vector2.DOWN * 60.0 if direction.y == 0.0 else Vector2.ZERO
  _velocity = move_and_slide_with_snap(
    _velocity, snap, FLOOR_NORMAL, true
  )
  if allow_shoot:
    shoot()

  $life_bar.set_value(life)
  $life_bar.visible = life < $life_bar.max_value
  #$skin/animation.play("walk")

func get_direction() -> Vector2:
  return Vector2(
    right - left,
    -top if is_on_floor() and top else 0.0
  )

func calculate_move_velocity(
    linear_velocity: Vector2,
    direction: Vector2,
    speed: Vector2,
    is_jump_interrupted: bool
  ) -> Vector2:
  var velocity: = linear_velocity
  velocity.x = speed.x * direction.x
  if direction.y != 0.0:
    velocity.y = speed.y * direction.y
  if is_jump_interrupted:
    velocity.y = 0.0
  return velocity

func calculate_stomp_velocity(linear_velocity: Vector2, stomp_impulse: float) -> Vector2:
  var stomp_jump: = -speed.y if Input.is_action_pressed("jump") else -stomp_impulse
  return Vector2(linear_velocity.x, stomp_jump)

func shoot():
  $weapon_container.get_child(0).shoot()

func turn_around():
  $skin.set_flip_h(true)
  $weapon_container.position.x *= -1
  $weapon_container.get_child(0).turn_around()
  flipped = !flipped
