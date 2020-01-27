extends Node2D

onready var textures = {
  'cat': { 'body': preload('res://images/game/cat/scale/cat_body.png'),
           'foot': preload('res://images/game/cat/scale/cat_foot.png'),
           'hand': preload('res://images/game/cat/scale/cat_hand.png') },
  'bear': { 'body': preload('res://images/game/bear/scale/bear_body.png'),
            'foot': preload('res://images/game/bear/scale/bear_foot.png'),
            'hand': preload('res://images/game/bear/scale/bear_hand.png') }
}
onready var menu = load('res://scenes/menu.tscn')

func _ready():
  $text_animation.play('anim_text')

func _input(event):
  if (event is InputEventKey or event is InputEventJoypadButton) and event.pressed:
    queue_free()
    get_tree().get_root().add_child(menu.instance())

func _on_text_animation_animation_finished(anim_name):
  $text_animation.play('anim_text')

func init(players, deathes):
  $first_player/body.set_texture(textures[players[0]['skin']]['body'])
  $first_player/left_foot.set_texture(textures[players[0]['skin']]['foot'])
  $first_player/right_foot.set_texture(textures[players[0]['skin']]['foot'])
  $first_player/hand.set_texture(textures[players[0]['skin']]['hand'])
  $first_player/center_death/count.set_text(
                                    str(deathes[0]) + ' ' + $first_player/center_death/count.get_text())
  
  if players.size() == 1:
    $second_player.hide()
    return
  $second_player/body.set_texture(textures[players[1]['skin']]['body'])
  $second_player/left_foot.set_texture(textures[players[1]['skin']]['foot'])
  $second_player/right_foot.set_texture(textures[players[1]['skin']]['foot'])
  $second_player/hand.set_texture(textures[players[1]['skin']]['hand'])
  $second_player/center_death/count.set_text(
                                    str(deathes[1]) + ' ' + $first_player/center_death/count.get_text())
 