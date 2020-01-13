extends KinematicBody2D

export var speed: = Vector2(400.0, 500.0)
export var gravity: = 3500.0
export var device_id: = 0
export var life: = 100

var _velocity: = Vector2.ZERO

const FLOOR_NORMAL: = Vector2.UP

var left: = 0.0
var right: = 0.0
var top: = 0.0
var allow_shoot: = false

func _ready():
  $weapon.active_enemy_trigger()

func _input(event: InputEvent) -> void:
  if event.get_device() != device_id: return

  if event.is_action('move_left'): left = event.get_action_strength('move_left')
  if event.is_action('move_right'): right = event.get_action_strength('move_right')
  if event.is_action('jump'): top = event.get_action_strength('jump')
  if event.is_action('shoot'): allow_shoot = event.is_action_pressed('shoot')

func _physics_process(delta: float) -> void:
  _velocity.y += gravity * delta
  var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
  var direction: = get_direction()
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
  $weapon.shoot()

func _on_damage_detector_area_entered(area):
  var damage_dealler = area.get_owner()
  life -= damage_dealler.damage
  if life <= 0:
    print('Death!')
