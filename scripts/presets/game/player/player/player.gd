extends BasePlayer

signal dead

func _on_damage_detector_area_entered(area):
  var damage_dealler = area.get_owner()
  if damage_dealler.name == 'door':
    return

  life -= damage_dealler.damage
  if life <= 0:
    emit_signal('dead')
