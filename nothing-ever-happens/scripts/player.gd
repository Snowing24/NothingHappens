extends CharacterBody2D


@onready var gun = get_node("gun")



var drag = 0.8
const JUMP_VELOCITY = -500
var speed = 100
var gun_dir
var health = 1000
#var money = 0
var direction
var dead = false
var floor_angle

func _process(_delta: float) -> void:
	#health
	if health <= 0:
		dead = true
	elif health > 0:
		dead = false
		
	if dead == true:#die
		queue_free()
		print("dead")
		
func _physics_process(_delta: float) -> void:
	
	#Gravity
	if not is_on_floor(): #if not on floor, apply gravity
		velocity += get_gravity() #velocity is having negative y force (gravity) added, and it is * delta becasue it needs to be
	
	#Makes changes based on if player is in air or not.
	if is_on_floor():
		#Floor Drag
		drag = 0.8
		#Jump code
		if Input.is_action_just_pressed("Jump"):
			velocity.y += JUMP_VELOCITY
	else:
		#Air Drag
		#drag = 0.75
		pass
	
	#direction var
	direction = Input.get_action_strength("Right",false)-Input.get_action_strength("Left",false)		
	
	#walking
	velocity.x += direction * speed * drag #move
			#IM A GENIUS!!!! uses .9 as a base and the lower the number the more "grip" you have so you can walk or accelerate faster, and on slick surfaces you accelerate slower and have a lower speed and lower max speed.
	
	velocity.x *= drag
	
	#SLOPE
	floor_angle = get_floor_normal().x
	global_rotation = floor_angle
	#velocity = velocity.rotated(floor_angle)#rotate vel based on slope
	
	move_and_slide() #allows player to move ig
	
