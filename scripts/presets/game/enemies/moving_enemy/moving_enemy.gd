extends BaseEnemy

var last_position: = Vector2.ZERO

func _ready():
  right = 1.0
  last_position = position

func _physics_process(delta):
  validate_current_target()
  move(delta)
  calculate_direction()
  calculate_flipping()
  last_position = position
  $life_bar.set_value(life)
  $life_bar.visible = life < $life_bar.max_value

  if !current_target:
    return
  if is_looking_at(current_target):
    $weapon.shoot()
    return
  turn_around()

func calculate_direction():
  if current_target:
    right = 0.0
    left = 0.0
    if current_target.position.x > position.x:
      right = 1.0
      return
    left = 1.0
    return

func calculate_flipping():
  if current_target:
    return
  if (right > 0 and flipped) or (left > 0 and !flipped):
    turn_around()

func _on_block_detector_body_entered(body):
  right = 1.0 - right
  left = 1.0 - left
