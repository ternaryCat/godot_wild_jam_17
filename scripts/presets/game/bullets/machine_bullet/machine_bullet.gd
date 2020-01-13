extends Node2D

export var direction_angle: = 0.0
export var speed: = 2000
var damage = 1

func _process(delta):
  var velocity = Vector2(cos(direction_angle), sin(direction_angle)) * speed * delta
  position += velocity

func _on_dead_timer_timeout():
  queue_free()

func active_enemy_trigger():
  $enemy_trigger.monitorable = true
  $enemy_trigger.monitoring = true

func active_player_trigger():
  $player_trigger.monitorable = true
  $player_trigger.monitoring = true

func _on_enemy_trigger_area_entered(area):
  queue_free()

func _on_player_trigger_area_entered(area):
  queue_free()
