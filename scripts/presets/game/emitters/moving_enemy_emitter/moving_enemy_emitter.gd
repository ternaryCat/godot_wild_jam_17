extends Node2D

onready var enemy: = preload('res://presets/game/enemies/moving_enemy.tscn')

func _on_emitter_timer_timeout():
  var new_enemy: = enemy.instance()
  new_enemy.position = $spawn_point.get_global_position()
  $enemies.add_child(new_enemy)
