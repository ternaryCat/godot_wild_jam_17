extends Node

signal action_detected(action, params)
signal position_corrected(position)

var actions: = []
var correct_positions: = []
var time: = 0.0

func _process(delta):
  if actions.size() == 0:
    return

  time += delta
  if actions.front()['time'] <= time:
    var action = actions.pop_front()
    emit_signal('action_detected', action['name'], action['params'])
    _process(delta)
  correct_position()

func correct_position() -> void:
  if correct_positions.size() != 0 and correct_positions.front()['time'] <= time:
    emit_signal('position_corrected', correct_positions.pop_front()['position'])
    correct_position()
  
