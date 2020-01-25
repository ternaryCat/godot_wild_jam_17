extends Camera2D

var players: = []

func _process(delta):
  if players.empty():
    return

  set_position(calculate_position())
  set_zoom(calculate_zoom())

func calculate_position():
  var new_position: = Vector2.ZERO
  for player in players:
    new_position += player.get_position()
  new_position /= players.size()
  return new_position

func calculate_zoom():
  var lowest_x: = 0
  var lowest_y: = 0
  var largest_x: = 0
  var largest_y: = 0

  for player in players:
    if player.get_position().x < lowest_x:
      lowest_x = player.get_position().x
    if player.get_position().y < lowest_y:
      lowest_y = player.get_position().y
    if player.get_position().x > largest_x:
      largest_x = player.get_position().x
    if player.get_position().y > largest_y:
      largest_y = player.get_position().y
  var x_scale: float = float(largest_x - lowest_x) / ProjectSettings.get_setting('display/window/size/width')
  var y_scale: float = float(largest_y - lowest_y) / ProjectSettings.get_setting('display/window/size/height')
  var largest_scale: = x_scale if x_scale > y_scale else y_scale
  largest_scale += 0.3
  return Vector2(largest_scale, largest_scale) if largest_scale > 1 else Vector2.ONE
