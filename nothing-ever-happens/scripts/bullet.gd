extends Node2D


@onready var ray = get_node("RayCast2D") as RayCast2D #imports raycast node into bullet script

var speed = 20 #vector 2 rotated to the angle of the dir it was fired
var collider #what the bullet hits
var new_position
var damage #is also given to bullet from the gun.
#var speed_mod #affects the speed of the bullet in percentage, is a stat from the gun. 1 is 100 percent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	new_position = position + speed * delta #makes a var that is its next position based on the vector that moves it
		
	ray.target_position = ray.to_local(new_position) #sets the target of the ray to the position it will move to next frame
	ray.force_raycast_update() #forces raycast update, i think makes it update between frames or smthn idk. you just need it ig
	
	collider = ray.get_collider()
	#to apply damage just apply it to the collider. ex: collider.health -= damage

	
	if collider:
		queue_free() #deletes itself
	else:
		position = new_position #so if it doesnt collide with a wall, then it will move to its next position, otherwise it will be at where it collided
	rotation = speed.angle() #rotates the bullet to face the direction of the speed vector2
