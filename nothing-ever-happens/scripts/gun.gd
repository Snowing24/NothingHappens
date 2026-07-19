extends Node2D



var bullet_timer = 0 #timer for the bullets to fire
var cooldown = 0.1
var bullet_scene = preload("res://Scenes/bullet.tscn") #loads bullet scene
var bullet_spread = 5
var damage = 1
var speed = 100


func shoot(): #func shoots a bullet

	print("shoot")

	var bullet = bullet_scene.instantiate() #defines var bullet as the instantiated bullet scene
	
	bullet.speed = Vector2(speed, 0).rotated(global_rotation)
	bullet.speed =  bullet.speed.rotated(deg_to_rad(randf_range(-bullet_spread,bullet_spread)))  #rotates bullet to gun rotation, adds spread
	bullet.damage = damage
	
	get_parent().add_sibling(bullet)  #makes the bullet scene a sibling of the player (child of node 2d and completeley independent
	bullet.z_index = self.z_index - 1 #draws bullet underneath the player
	bullet.global_position = global_position + (global_transform.x*100) #puts bullet at gun position (bullet.global_position = global_position) then makes a releative transformation forward from the gun one unit * 100 (move bullet 100 units from the gun base to make bullet at end of gun barrel, transform.x is a forward vector relative the to object, which in this case is the gun)

	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	bullet_timer -= delta #bullet timer goes down 1 every second (and every number inbetween bc thats how delta works obv)
	
	if not Input.get_connected_joypads():
		look_at(get_global_mouse_position())
		
	if Input.is_action_pressed("Fire"): #input fire? uses func shoot to shoot bullet
		if bullet_timer <= 0:
			shoot()
			bullet_timer = cooldown #makes bullet timer 0.2 to prevent the if statement from going off, it can only go off after these 0.2 seconds get depleted.


	rotation_degrees = fposmod(rotation_degrees, 360) #uhhhhhhhhhh idk something to do with the gun flipping (see below)
	if rotation_degrees > 90 and rotation_degrees < 270: #once he angle of the gun goes over the top of the char (270) the gun flips over
		scale.y = -0.5 #the scale of the gun goes negative, which flips the gun
		scale.x = 0.3
	else:
		scale.y = 0.5
		scale.x = 0.3
