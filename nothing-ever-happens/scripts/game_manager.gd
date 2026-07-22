extends Node

@onready var velocity_label: Label = $VelocityLabel
@onready var player_0: CharacterBody2D = $"../player0"

func _process(delta: float) -> void:
	velocity_label.text = "Xvel:\n" + str(ceil(player_0.velocity.x)) + "\nYvel:\n" + str(ceil(player_0.velocity.y))
