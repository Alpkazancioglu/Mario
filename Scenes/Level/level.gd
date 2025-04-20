extends Node2D
@onready var mario: Player = $mario


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("getDamaged"):
		mario.turnSmallMario(mario.marioState)
		
