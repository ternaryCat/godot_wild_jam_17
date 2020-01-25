extends Node

signal dead(player_id, actions, correct_positions_list, gun, texture_pack_name)

func _on_player_dead():
  $input_interface.add_death_action()
  emit_signal('dead', 
              $input_interface.device_id,
              $input_interface.actions,
              $input_interface.corrected_positions,
              $player.choosed_gun,
              $player.texture_pack_name)
  queue_free()

func choose_gun(gun):
  $player.choosed_gun = gun

func set_device_id(device_id: int) -> void:
  $input_interface.device_id = device_id

func get_device_id():
  return $input_interface.device_id

func set_position(position):
  $player.position = position

func set_textures(texture_pack_name: String) -> void:
  $player.set_textures(texture_pack_name)

func get_position():
  return $player.get_position()