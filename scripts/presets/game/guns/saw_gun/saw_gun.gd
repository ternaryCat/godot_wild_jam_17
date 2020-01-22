extends BaseGun

var damage: = 50
var destructible: = false

func shoot():
  $animation.play('atack')
  if !$delay_timer.is_stopped() or !$atack_period_timer.is_stopped():
    return

  $damage_area/collision.disabled = false
  $atack_period_timer.start()

func stop_shoot():
  $atack_period_timer.stop()
  $animation.play('stop')

func turn_around():
  flipped = !flipped
  $skin.set_flip_h(flipped)
  $skin.position.x *= -1
  $saw.position.x *= -1
  $damage_area.position.x *= -1

func _on_atack_period_timer_timeout():
  $damage_area/collision.disabled = true
  $delay_timer.start()
  