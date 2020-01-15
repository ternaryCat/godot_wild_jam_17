extends BasePlayer

func _on_damage_detector_area_entered(area):
  var damage_dealler = area.get_owner()
  life -= damage_dealler.damage
  if life <= 0:
    queue_free()

func set_actions(actions):
  $actions_interface.actions = actions

func set_correct_positions(positions):
  $actions_interface.correct_positions = positions

func _on_actions_interface_position_corrected(position):
  global_position = position
