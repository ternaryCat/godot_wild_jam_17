extends Node2D

enum SIDES { LEFT, RIGHT, MIDDLE }

onready var game: = preload('res://scenes/game.tscn')
onready var menu: = load('res://scenes/menu.tscn')

var characters = [
  { 'choosed': null, 'current': SIDES.MIDDLE, 'playing': false },
  { 'choosed': null, 'current': SIDES.MIDDLE, 'playing': false }
]

var to_game_pressed: = false
var only_one_player: = true

func _input(event):
  if event.is_action_pressed('back'):
    queue_free()
    get_tree().get_root().add_child(menu.instance())
  if characters.size() <= event.device:
    return
  if event.is_action_pressed('move_left'):
    if characters[event.device]['current'] == SIDES.RIGHT:
      characters[event.device]['choosed'] = SIDES.MIDDLE
    elif characters[event.device]['current'] == SIDES.MIDDLE and is_side_empty(SIDES.LEFT):
      characters[event.device]['choosed'] = SIDES.LEFT

  if event.is_action_pressed('move_right'):
    if characters[event.device]['current'] == SIDES.LEFT:
      characters[event.device]['choosed'] = SIDES.MIDDLE
    elif characters[event.device]['current'] == SIDES.MIDDLE and is_side_empty(SIDES.RIGHT):
      characters[event.device]['choosed'] = SIDES.RIGHT

  if event.is_action('ui_accept'):
    to_game_pressed = true

func _process(delta):
  for character_index in range(characters.size()):
    var character = characters[character_index]
    if character['choosed'] == null or character['playing']:
      continue

    if character['choosed'] == SIDES.MIDDLE:
      if character['current'] == SIDES.RIGHT:
        get_node('player_' + str(character_index + 1) + '_animation').play('release_right')
      elif character['current'] == SIDES.LEFT:
        get_node('player_' + str(character_index + 1) + '_animation').play('release_left')

    elif character['choosed'] == SIDES.LEFT:
      get_node('player_' + str(character_index + 1) + '_animation').play('choose_left')
      $cat/animation.play('choose')
    elif character['choosed'] == SIDES.RIGHT:
      get_node('player_' + str(character_index + 1) + '_animation').play('choose_right')
      $bear/animation.play('choose')
    character['playing'] = true
    character['current'] = character['choosed']
    character['choosed'] = null

  $player_2.visible = !only_one_player
  correct_characters_options()
  $to_game_label.visible = is_prepared()
  if to_game_pressed:
    to_game()

func _on_player_1_animation_animation_finished(anim_name):
  characters[0]['playing'] = false
  characters[0]['choosed'] = null

func _on_player_2_animation_animation_finished(anim_name):
  characters[1]['playing'] = false
  characters[1]['choosed'] = null

func correct_characters_options():
  if characters.size() > 1 and only_one_player:
    characters.pop_back()

func is_side_empty(side) -> bool:
  for charactaer in characters:
    if charactaer['current'] == side:
      return false
  return true

func is_prepared() -> bool:
  for character in characters:
    if character['current'] == null or character['current'] == SIDES.MIDDLE:
      return false
  return true

func to_game():
  to_game_pressed = false
  if !is_prepared():
    return

  queue_free()
  var new_game = game.instance()
  new_game.players = get_skins()
  get_tree().get_root().add_child(new_game)

func get_skins():
  var skins = []
  for character in characters:
    skins.append({ 'skin': 'cat' if character['current'] == SIDES.LEFT else 'bear' })
  return skins
