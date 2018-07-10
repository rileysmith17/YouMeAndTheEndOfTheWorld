extends TextureProgress

var health

func _ready():
	set_process(true)
	pass

func _process(delta):
	health = get_node("/root/Combat/TileMap/Enemy").get("totalHealth")
	self.set_value(health)
	if(health <= 0):
		print("GAME OVER")
	pass
