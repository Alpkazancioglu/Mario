extends Area2D
class_name Coin

enum _COIN_TYPE {BUMBED,COLLECTABLE}
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var sound: AudioStreamPlayer = $sound

@export var type: _COIN_TYPE

func setup(coinType: _COIN_TYPE) -> void:
	type = coinType
	if type == _COIN_TYPE.BUMBED:
		animation.play("bumped")
	elif type == _COIN_TYPE.COLLECTABLE:
		animation.play("idle")
	

func _ready() -> void:
	if type == _COIN_TYPE.COLLECTABLE:
		animation.play("idle")



func _process(delta: float) -> void:
	pass

func bumbCoin() -> void:
	
	sound.play()
	
	var tween: Tween = get_tree().create_tween()
	var oldPos: Vector2 = global_position
	var destination:Vector2 = Vector2(global_position.x,global_position.y - 40)
	tween.tween_property(self,"global_position",destination,0.5)
	tween.tween_callback(Callable(self, "_on_bump_animation_end"))
	tween.tween_property(self,"global_position",oldPos,0.5)
	await  tween.finished
	queue_free()

func collectCoin() -> void:
	sound.play()
	animation.visible = false
	await sound.finished
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if type == _COIN_TYPE.COLLECTABLE:
			collectCoin()
