extends Node2D

@onready var target = get_parent().get_node("Target")
var speed = 200 #p/s to target


func _process(delta: float) -> void:
	look_at(target.position)
	
	rotation_degrees = fposmod(rotation_degrees, 360)  #just copied this from gun script lol
	
	if rotation_degrees > 90 and rotation_degrees < 270: 
		scale.y = -1
		scale.x = 1
	else:
		scale.y = 1
		scale.x = 1
	
	position += transform.x * speed * delta
