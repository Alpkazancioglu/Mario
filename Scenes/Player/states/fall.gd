extends State
@onready var coyote_timer: Timer = $coyoteTimer

var coyoteJump: bool = false


func enter()->void:
	player.animation.play("jump")
	coyote_timer.start()
	coyoteJump = true
	
func update(delta: float) -> State:
	player.applyGravity(delta)
	
	if player.velocity.y == 0 && player.is_on_floor():
		return states["idle"]
	
	if coyoteJump && player.direction.y == 1 && (player.prevState != states["jump"]):
		return states["jump"]
		
	
	
	
	return states["fall"]

func exit() -> void:
	coyote_timer.stop()


func _on_timer_timeout() -> void:
	coyoteJump = false
