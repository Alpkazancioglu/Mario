extends State




func enter()->void:
	player.animation.play("idle")
	
	
func update(delta: float) -> State:
	
	player.velocity.x = move_toward(player.velocity.x, 0 , player.SPEED * delta * 4)
	player.applyGravity(delta)
	
	if player.direction.x != 0 && player.is_on_floor():
		return states["move"]
	
	if player.direction.y == 1 && player.is_on_floor():
		return states["jump"]
	
	
	return states["idle"]

func exit() -> void:
	pass
