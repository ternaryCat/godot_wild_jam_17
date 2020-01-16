extends Node2D

signal player_entered

func _on_player_detector_area_entered(area):
  emit_signal('player_entered')
