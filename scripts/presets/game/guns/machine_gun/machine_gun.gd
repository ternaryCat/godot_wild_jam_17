extends Node2D

onready var bullet = preload('res://presets/game/bullets/machine_bullet.tscn')

func shoot():
  var new_bullet = bullet.instance()
  new_bullet.set_position($bullet_point.get_global_position())
  new_bullet.direction_angle = get_global_rotation()
  $bullets.add_child(new_bullet)
