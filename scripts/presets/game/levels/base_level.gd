extends Node2D
class_name BaseLevel

signal level_completed

const PLAYER_POSITION_DISTANCE_DELTA: = Vector2(50, 0)

func get_player_position(player_id: int) -> Vector2:
  return $player_position.get_position() + PLAYER_POSITION_DISTANCE_DELTA * player_id

func _on_dore_player_entered():
  emit_signal('level_completed')
