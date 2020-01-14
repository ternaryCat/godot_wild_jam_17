extends BaseGun

var damage: = 50

func shoot():
  if !$delay_timer.is_stopped() or !$atack_period_timer.is_stopped():
    return

  $damage_area/collision.disabled = false
  $atack_period_timer.start()

func stop_shoot():
  $atack_period_timer.stop()

func turn_around():
  $skin.set_flip_h(true)
  $skin.position.x *= -1
  $damage_area.position.x *= -1
  flipped = !flipped

func _on_atack_period_timer_timeout():
  $damage_area/collision.disabled = true
  $delay_timer.start()
  