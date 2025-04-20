extends CharacterBody2D
class_name Mushroom

const SPEED: int = 50 

var isReadyToGo: bool = false
var direction:int = 1

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if isReadyToGo:
		move(delta)
		move_and_slide()
			
	
## makes the mushroom rise from the block
func bumbed() -> void:
	
	var tween: Tween = get_tree().create_tween()
	var oldPos: Vector2 = global_position
	var destination:Vector2 = Vector2(global_position.x,global_position.y - 16)
	tween.tween_property(self,"global_position",destination,1)
	await tween.finished
	isReadyToGo = true


func move(delta: float) -> void:
	if is_on_wall():
		direction = direction * -1
	velocity.x = SPEED * direction
	velocity.y += get_gravity().y * delta
	pass
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.health += 1
		body.turnBigMario(body.marioState)
		queue_free()
