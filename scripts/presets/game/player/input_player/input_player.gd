extends Node

signal dead(player_id, actions, correct_positions_list, gun)

func _on_player_dead():
  $input_interface.add_death_action()
  emit_signal('dead', 
              $input_interface.device_id,
              $input_interface.actions,
              $input_interface.corrected_positions,
              $player.choosed_gun)

func choose_gun(gun):
  $player.choosed_gun = gun

func get_device_id():
  return $input_interface.device_id

func set_position(position):
  $player.position = position