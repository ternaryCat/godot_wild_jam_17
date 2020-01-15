extends BaseEnemy

func _physics_process(delta):
  move(delta)
  $life_bar.set_value(life)
  $life_bar.visible = life < $life_bar.max_value

  if !current_target:
    return
  if is_looking_at(current_target):
    $weapon.shoot()
    return
  turn_around()
