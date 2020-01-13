extends Node2D

onready var bullet = preload('res://presets/game/bullets/machine_bullet.tscn')
var flipped: = false

func shoot():
  var new_bullet = bullet.instance()
  new_bullet.set_position($bullet_point.get_global_position())
  var bullet_rotation: = get_global_rotation()
  if flipped:
    bullet_rotation += PI
  new_bullet.direction_angle = bullet_rotation
  $bullets.add_child(new_bullet)

func turn_around():
  $skin.set_flip_v(true)
  $skin.position.x *= -1
  $bullet_point.position.x *= -1
  flipped = !flipped
