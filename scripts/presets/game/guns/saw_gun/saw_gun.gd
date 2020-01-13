extends BaseGun

var damage: = 50

func shoot():
  if !$delay_timer.is_stopped() or !$atack_period_timer.is_stopped():
    return

  $damage_area/collision.disabled = false
  $atack_period_timer.start()

func _on_atack_period_timer_timeout():
  $damage_area/collision.disabled = true
  $delay_timer.start()
  