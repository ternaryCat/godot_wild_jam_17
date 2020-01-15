extends Node2D

onready var level = preload('res://presets/game/levels/level_1.tscn')
onready var player = preload('res://presets/game/players/player.tscn')
onready var player_dummy = preload('res://presets/game/players/player_dummy.tscn')

var player_lives: = []
var need_reload = false

func _ready():
  reload()

func _physics_process(delta):
  if need_reload:
    reload()
    need_reload = false

func reload():
  for child in get_children():
    child.queue_free()

  var new_level = level.instance()
  var new_player = player.instance()
  new_player.position = new_level.get_player_position(new_player.get_device_id())
  new_player.connect('dead', self, '_on_player_dead')
  add_child(new_level)
  add_child(new_player)

  for last_live in player_lives:
    var new_player_dummy = player_dummy.instance()
    new_player_dummy.position = new_level.get_player_position(last_live['player_id'])
    new_player_dummy.set_actions(last_live['actions'].duplicate())
    new_player_dummy.set_correct_positions(last_live['correct_positions_list'].duplicate())
    add_child(new_player_dummy)

func _on_player_dead(player_id, actions, correct_positions_list):
  player_lives.append({ 'player_id': player_id, 'actions': actions, 'correct_positions_list': correct_positions_list })
  need_reload = true
