extends BaseGun

onready var bullet = preload('res://presets/game/bullets/machine_bullet.tscn')

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
