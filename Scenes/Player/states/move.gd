extends State

var isSliding: bool = false

func enter()->void:
	pass
	
	
func update(delta: float) -> State:
	player.velocity.x = move_toward(player.velocity.x,player.SPEED * player.direction.x,player.SPEED * delta * 2)
	player.applyGravity(delta)
	
	player.flipSprite()
	
	if sign(player.velocity.x) != player.direction.x:
		player.playAnim("slide")
		isSliding = true
	else:
		isSliding = false
		player.playAnim("move")
	
	
	if player.velocity.y > 0 && !player.is_on_floor():
		return states["fall"]
	
	if player.direction.x == 0 && player.is_on_floor():
		return states["idle"]
	
	if player.direction.y == 1 && player.is_on_floor():
		return states["jump"]
	
	
	return states["move"]

func exit() -> void:
	pass
