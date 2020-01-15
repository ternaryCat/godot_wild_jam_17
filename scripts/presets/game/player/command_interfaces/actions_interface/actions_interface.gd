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
  correct_position(0)

func correct_position(offset: int) -> bool:
  if correct_positions.size() == 0 or correct_positions.size() <= offset or correct_positions[offset]['time'] > time:
    return false

  if !correct_position(offset + 1):
    emit_signal('position_corrected', correct_positions[offset]['position'])
    for e in range(offset):
      correct_positions.pop_front()
  return true
