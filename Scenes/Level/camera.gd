extends Camera2D
@onready var mario: Player = $"../mario"
@onready var left_border: StaticBody2D = $"../LeftBorder"

var leftBorder: int = 0

var viewportHalf: int = 0

@export var NobackMode: bool = false

func _ready() -> void:
	leftBorder = mario.global_position.x
	viewportHalf = get_viewport_rect().size.x/2
	

func _process(delta: float) -> void:
	if NobackMode:
		if mario.global_position.x > leftBorder:
			leftBorder = mario.global_position.x
			global_position.x = mario.global_position.x - viewportHalf
			left_border.global_position.x = global_position.x
			mario.leftBorder = global_position.x + 5 # 5 is half of the mario texture width
			traverse_all_children(get_parent())
			
	else:
		global_position.x = mario.global_position.x - viewportHalf
		
func traverse_all_children(node):
	for child in node.get_children():
		if child.is_in_group("deleteableObjects"):
			if child.global_position.x < global_position.x - 16:
				print(child)
				child.queue_free()
		traverse_all_children(child) # alt çocuklara git
