extends Control

signal pressed

export var label: = ''

func _process(delta):
  $center/label.set_text(label)
  $center/button.set_pressed(true)

func set_focus():
  $center/button.grab_focus()

func _on_button_pressed():
  emit_signal('pressed')
