extends BasePlayer

signal dead(player_id, actions, correct_positions_list)

func _on_damage_detector_area_entered(area):
  var damage_dealler = area.get_owner()
  life -= damage_dealler.damage
  if life <= 0:
    $input_interface.add_death_action()
    emit_signal('dead', get_device_id(), $input_interface.actions, get_correct_positions_list())

func get_device_id():
  return $input_interface.device_id

func get_correct_positions_list():
  return $input_interface.corrected_positions