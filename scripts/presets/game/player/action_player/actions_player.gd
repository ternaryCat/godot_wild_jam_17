extends Node

func set_actions(actions):
  $actions_interface.actions = actions

func set_correct_positions(positions):
  $actions_interface.correct_positions = positions

func _on_actions_interface_position_corrected(position):
  $player.global_position = position

func _on_player_dead():
  queue_free()

func set_position(position):
  $player.position = position

func change_gun(gun_name: String) -> void:
  $player.change_gun(gun_name)

func set_textures(texture_pack_name: String) -> void:
  $player.set_textures(texture_pack_name)
