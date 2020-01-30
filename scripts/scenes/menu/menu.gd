extends Control

onready var characters_menu = preload('res://scenes/characters_menu.tscn')

func _ready():
  $buttons/center_one/one_player.grab_focus()

func _process(delta):
  set_active_two_players(gamepads_size() >= 2)

func set_active_two_players(status):
  $buttons/center_two/two_players.disabled = !status
  $center_label.visible = !status

func gamepads_size():
  return Input.get_connected_joypads().size()

func _on_one_player_pressed():
  queue_free()
  get_tree().get_root().add_child(characters_menu.instance())

func _on_two_players_pressed():
  queue_free()
  var new_characters_menu = characters_menu.instance()
  new_characters_menu.only_one_player = false
  get_tree().get_root().add_child(new_characters_menu)

func _on_about_pressed():
  print(22)
