extends Node2D

export var life: = 300
onready var enemy: = preload('res://presets/game/enemies/moving_enemy.tscn')

func _process(delta):
  if life <= 0:
    return
    
  $life_bar.set_value(life)
  $life_bar.visible = life < $life_bar.max_value

func _on_emitter_timer_timeout():
  if life <= 0:
    $emitter_timer.one_shot = false
    $emitter_timer.stop()
    return
  var new_enemy: = enemy.instance()
  new_enemy.position = $spawn_point.get_global_position()
  $enemies.add_child(new_enemy)

func _on_damage_area_area_entered(area):
  var damage_dealler = area.get_owner()
  life -= damage_dealler.damage
  if life <= 0:
    $skin.hide()
    $life_bar.hide()
    $damage_area.monitorable = false
    $damage_area.monitoring = false
