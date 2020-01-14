extends BaseBullet

const BODIES_LIMIT: = 3
const WEAPONS_LIMIT: = 3

var bodies_count: = 0
var weapons_count: = 0

func _ready():
  damage = 15
  speed = 1500

func active_enemy_trigger():
  $enemy_trigger.monitorable = true
  $enemy_trigger.monitoring = true
  $enemy_weapon_trigger.monitoring = true

func active_player_trigger():
  $player_trigger.monitorable = true
  $player_trigger.monitoring = true
  $player_weapon_trigger.monitoring = true

func _on_enemy_trigger_area_entered(area):
  bodies_count += 1
  if bodies_count >= BODIES_LIMIT:
    queue_free()

func _on_player_trigger_area_entered(area):
  bodies_count += 1
  if bodies_count >= BODIES_LIMIT:
    queue_free()

func _on_weapon_trigger_area_entered(area):
  var bullet = area.get_owner()
  if !bullet.destructible and weapons_count < WEAPONS_LIMIT:
    return
  weapons_count += 1
  bullet.queue_free()
