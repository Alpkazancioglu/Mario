extends StaticBody2D
class_name Brick

var isBumbed: bool = false


func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_bottom_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.currentState == body.states["jump"]:
			print("block bottom colliding")
			bumbBlock()
			

func bumbBlock() -> void:
	var tween: Tween = get_tree().create_tween()
	isBumbed = true
	
	var oldPos: Vector2 = global_position
	var destination:Vector2 = Vector2(global_position.x,global_position.y - 8)
	tween.tween_property(self,"global_position",destination,0.1)
	tween.tween_callback(Callable(self, "_on_bump_animation_end"))
	tween.tween_property(self,"global_position",oldPos,0.1)


func breakBlock() -> void:
	isBumbed = true
	queue_free()


func _on_bump_animation_end() -> void:
	isBumbed = false
	
