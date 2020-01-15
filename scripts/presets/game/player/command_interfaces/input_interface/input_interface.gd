extends Node

signal action_detected(action, params)

export var device_id: = 0
var actions: = []
var time: = 0.0

func _input(event: InputEvent) -> void:
  if event.get_device() != device_id: return

  if event.is_action('move_left'): detect_action('move_left', { 'strength': event.get_action_strength('move_left') })
  if event.is_action('move_right'): detect_action('move_right', { 'strength': event.get_action_strength('move_right') })
  if event.is_action('jump'): detect_action('jump', { 'strength': event.get_action_strength('jump') })
  if event.is_action('shoot'): detect_action('shoot', { 'allow': event.is_action_pressed('shoot') })

func _process(delta):
  time += delta

func detect_action(action, params):
  actions.append({ 'name': action, 'time': time, 'params': params })
  emit_signal('action_detected', action, params)
  print(actions)
