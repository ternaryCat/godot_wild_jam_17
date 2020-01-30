extends TextureButton

func _ready():
  $top.set_texture(get_normal_texture())

func _focus_entered():
  $player.play('active')

func _focus_exited():
  $player.play('stop')
