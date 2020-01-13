extends Node2D

export var direction_angle: = 0.0
export var speed: = 2000

func _process(delta):
  var velocity = Vector2(cos(direction_angle), sin(direction_angle)) * speed * delta
  position += velocity

func _on_dead_timer_timeout():
  queue_free()
