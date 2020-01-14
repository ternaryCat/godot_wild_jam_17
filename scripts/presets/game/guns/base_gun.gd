extends Node2D
class_name BaseGun

export var is_active_enemy_trigger: = false
export var is_active_player_trigger: = false
var flipped: = false
var bullet

func shoot():
  if !$delay_timer.is_stopped():
    return

  $delay_timer.start()
  var new_bullet = bullet.instance()
  new_bullet.set_position($bullet_point.get_global_position())
  if is_active_enemy_trigger:
    new_bullet.active_enemy_trigger()
  if is_active_player_trigger:
    new_bullet.active_player_trigger()

  var bullet_rotation: = get_global_rotation()
  if flipped:
    bullet_rotation += PI
  new_bullet.direction_angle = bullet_rotation
  $bullets.add_child(new_bullet)

func stop_shoot():
  pass

func turn_around():
  $skin.set_flip_v(true)
  $skin.position.x *= -1
  $bullet_point.position.x *= -1
  flipped = !flipped

func active_enemy_trigger():
  is_active_enemy_trigger = true

func active_player_trigger():
  is_active_player_trigger = true
