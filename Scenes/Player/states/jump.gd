extends State




func enter()->void:
	player.velocity.y = player.JUMP_VELOCITY
	player.playAnim("jump")
	
func update(delta: float) -> State:
	player.applyGravity(delta)
	player.velocity.x = move_toward(player.velocity.x,player.SPEED * player.direction.x,player.SPEED * delta)
	
	
	if player.direction.y != 1:
		player.velocity.y = move_toward(player.velocity.y,1, 2000 * delta)
	
	if player.velocity.y > 0:
		return states["fall"]
	
	
	if player.direction.x == 0 && player.is_on_floor():
		return states["idle"] 
	
	if player.direction.x != 0 && player.is_on_floor():
		return states["move"]
	
	return states["jump"]
	
	

func exit() -> void:
	pass
