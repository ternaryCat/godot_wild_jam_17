extends Node2D

export var players_count: = 1

onready var levels = [
  preload('res://presets/game/levels/level_1.tscn'),
  preload('res://presets/game/levels/level_2.tscn')
]
onready var player = preload('res://presets/game/players/input_player.tscn')
onready var player_dummy = preload('res://presets/game/players/actions_player.tscn')

var current_level: = 0
var player_lives: = []
var need_reload = true

var players_lives_count: = 0

func _physics_process(delta):
  if need_reload:
    reload()
    need_reload = false

func reload():
  players_lives_count = players_count
  clean_game()

  var new_level = levels[current_level].instance()
  new_level.connect('level_completed', self, '_on_next_level')
  add_child(new_level)
  for index in range(players_count):
    var new_player = player.instance()
    new_player.set_device_id(index)
    new_player.choose_gun('shot_gun')
    new_player.set_position(new_level.get_player_position(new_player.get_device_id()))
    new_player.connect('dead', self, '_on_player_dead')
    add_child(new_player)

  for last_live in player_lives:
    var new_player_dummy = player_dummy.instance()
    new_player_dummy.set_position(new_level.get_player_position(last_live['player_id']))
    new_player_dummy.set_actions(last_live['actions'].duplicate())
    new_player_dummy.set_correct_positions(last_live['correct_positions_list'].duplicate())
    add_child(new_player_dummy)
    new_player_dummy.change_gun(last_live['gun'])

func clean_game():
  for child in get_children():
    child.queue_free()

func _on_player_dead(player_id, actions, correct_positions_list, gun):
  player_lives.append({ 'player_id': player_id,
                        'actions': actions,
                        'correct_positions_list': correct_positions_list,
                        'gun': gun })
  players_lives_count -= 1
  print(player_id)
  if players_lives_count <= 0:
    need_reload = true

func _on_next_level():
  clean_game()
  current_level += 1
  player_lives = []
  if levels.size() == current_level:
    return
  need_reload = true
  