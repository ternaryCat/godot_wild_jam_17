extends Node2D

onready var levels = [
  preload('res://presets/game/levels/level_1.tscn'),
  preload('res://presets/game/levels/level_2.tscn')
]
onready var player = preload('res://presets/game/players/input_player.tscn')
onready var player_dummy = preload('res://presets/game/players/actions_player.tscn')

var current_level: = 0
var player_lives: = []
var need_reload: = true
var players: = []
var players_instances: = []

var players_lives_count: = 0

func _physics_process(delta):
  if need_reload:
    reload()
    need_reload = false

func reload():
  players_lives_count = players.size()
  clean_game()

  var new_level = levels[current_level].instance()
  new_level.connect('level_completed', self, '_on_next_level')
  $objects.add_child(new_level)
  for index in range(players.size()):
    var new_player = player.instance()
    players_instances.append(new_player)
    new_player.set_device_id(index)
    new_player.choose_gun('shot_gun')
    new_player.set_position(new_level.get_player_position(new_player.get_device_id()))
    new_player.connect('dead', self, '_on_player_dead')
    $objects.add_child(new_player)
    new_player.set_textures(players[index]['skin'])
  $camera.players = players_instances

  for last_live in player_lives:
    var new_player_dummy = player_dummy.instance()
    new_player_dummy.set_position(new_level.get_player_position(last_live['player_id']))
    new_player_dummy.set_actions(last_live['actions'].duplicate())
    new_player_dummy.set_correct_positions(last_live['correct_positions_list'].duplicate())
    $objects.add_child(new_player_dummy)
    new_player_dummy.change_gun(last_live['gun'])
    new_player_dummy.set_textures(last_live['texture_pack_name'])

func clean_game():
  players_instances = []
  $camera.players = []
  for child in $objects.get_children():
    child.queue_free()

func _on_player_dead(player_id, actions, correct_positions_list, gun, texture_pack_name):
  player_lives.append({ 'player_id': player_id,
                        'actions': actions,
                        'correct_positions_list': correct_positions_list,
                        'gun': gun,
                        'texture_pack_name': texture_pack_name })
  players_lives_count -= 1
  if players_lives_count <= 0:
    need_reload = true
  players_instances.remove(player_id)
  $camera.players = players_instances

func _on_next_level():
  clean_game()
  current_level += 1
  player_lives = []
  if levels.size() == current_level:
    return
  need_reload = true
  