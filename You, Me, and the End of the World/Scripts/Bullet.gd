extends KinematicBody2D

var damage = 45 #default damage
var spread = 15 #default spread
var speed = 1600 #default speed
var bleed = 0 #default bleed damage
var ricochet = 0 #the number of times the bullet ricochets before destroying
var explosion = false #default explosiveness
var poison = false #default poison value
var motion = Vector2(2,0)

onready var enemyHealth = get_node("/root/Combat/CombatHUD/EnemyHealth")
onready var playerHealth = get_node("/root/Combat/CombatHUD/PlayerHealth")

onready var enemy = self.get_parent().get_node("Enemy")
	
signal hit
signal hitUpdate

func _ready():
	set_process(true)
	if(!self.is_connected("hit", enemy, "_on_Bullet_hit")):
		self.connect("hit", enemy, "_on_Bullet_hit", [])
	self.connect("hitUpdate", enemyHealth, "hit", [])
	self.connect("hitUpdate", playerHealth, "hit", [])
	self.look_at(get_viewport().get_mouse_position())
	pass

func _process(delta):
	translate((speed * motion * delta))
	var collideCheck = move_and_collide(motion * delta)
	if(collideCheck != null):
		if(collideCheck.collider.name != "head" and collideCheck.collider.name != "torso"):
			print("Ouch!")
			#var enemy = get_node("/root/TileMap/Enemy")
			hide()
			queue_free()
		else:
			contact(collideCheck.collider);
	pass
	
func contact(body):
	print("Hit enemy")
	emit_signal("hit", body.name, damage)
	emit_signal("hitUpdate")
	#if ricochet < 1:
	destroy()

func destroy():
    #play explosion animation and sound
    queue_free()
