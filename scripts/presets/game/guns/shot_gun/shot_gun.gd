extends BaseGun

const BULLETS_COUNT: = 9
const RANGE_START: = -PI / 8
const RANGE_END: = PI / 8

func _ready():
  bullet = preload('res://presets/game/bullets/shot_bullet.tscn')

func spawn_bullet():
  var rotation_unit: = (RANGE_END - RANGE_START) / BULLETS_COUNT

  for e in range(BULLETS_COUNT):
    var bullet_rotation: = get_global_rotation() + RANGE_START + rotation_unit * e
    var new_bullet = bullet.instance()
    new_bullet.set_position($bullet_point.get_global_position())
    if is_active_enemy_trigger:
      new_bullet.active_enemy_trigger()
    if is_active_player_trigger:
      new_bullet.active_player_trigger()

    if flipped:
      bullet_rotation += PI
    new_bullet.direction_angle = bullet_rotation
    $bullets.add_child(new_bullet)
