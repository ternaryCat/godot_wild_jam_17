extends Node2D

export var life: = 100
var detected_players_list: = []
var current_target
var flipped: = false

func _ready():
  $weapon.active_player_trigger()

func _process(delta):
  $life_bar.set_value(life)
  $life_bar.visible = life < $life_bar.max_value

  if !current_target:
    return
  if is_looking_at(current_target):
    $weapon.shoot()
    return
  turn_around()

func choose_current_player():
  if current_target != null:
    return
  current_target = detected_players_list.pop_front()

func turn_around():
  $skin.set_flip_h(true)
  $weapon.position.x *= -1
  $weapon.turn_around()
  flipped = !flipped

func is_looking_at(player):
  return (detected_players_list.has(player) or current_target == player) and\
         ((position.x < player.position.x and !flipped) or (position.x >= player.position.x and flipped))

func add_player(player):
  if detected_players_list.has(player):
    return
  detected_players_list.append(player)

func remove_player(player):
  var player_index: = detected_players_list.find(player)
  if player_index == -1:
    return
  detected_players_list.remove(player_index)
  remove_player(player) # just in case

func _on_player_detector_area_entered(area):
  add_player(area.get_owner())
  choose_current_player()

func _on_player_detector_area_exited(area):
  remove_player(area.get_owner())
  if current_target == area.get_owner():
    current_target = null
  choose_current_player()

func _on_damage_detector_area_entered(area):
  var damage_dealler = area.get_owner()
  life -= damage_dealler.damage
  if life <= 0:
    queue_free()
