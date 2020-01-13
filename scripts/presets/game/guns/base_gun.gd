extends Node2D
class_name BaseGun

export var is_active_enemy_trigger: = false
export var is_active_player_trigger: = false
var flipped: = false

func turn_around():
  $skin.set_flip_v(true)
  $skin.position.x *= -1
  $bullet_point.position.x *= -1
  flipped = !flipped

func active_enemy_trigger():
  is_active_enemy_trigger = true

func active_player_trigger():
  is_active_player_trigger = true
