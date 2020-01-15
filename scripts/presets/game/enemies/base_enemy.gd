extends KinematicBody2D
class_name BaseEnemy

export var speed: = Vector2(30000.0, 1200.0)
export var gravity: = 1600.0
export var life: = 100

var detected_players_list: = []
var current_target
var flipped: = false

var _velocity: = Vector2.ZERO
const FLOOR_NORMAL: = Vector2.UP

var left: = 0.0
var right: = 0.0
var top: = 0.0

func _ready():
  $weapon.active_player_trigger()

func move(delta):
  _velocity += Vector2(0, gravity) * delta
  if is_on_floor():
    _velocity = Vector2.ZERO
  if !current_target:
    _velocity.x = (right - left) * speed.x * delta
  move_and_slide_with_snap(_velocity, _velocity, FLOOR_NORMAL, true)

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
