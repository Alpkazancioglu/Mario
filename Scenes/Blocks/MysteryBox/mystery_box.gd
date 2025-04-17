extends StaticBody2D

const COIN_SCENE = preload("res://Scenes/Coin/coin.tscn")
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

enum _ITEM_TYPES {COIN,MUSHROOM,STAR}


@export_group('Item')
@export var itemType: _ITEM_TYPES
@export var itemCount: int = 1




func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func createCoin() -> void:
	var coin = COIN_SCENE.instantiate()
	add_child(coin)
	coin.setup(Coin._COIN_TYPE.BUMBED)
	coin.bumbCoin()
	
	
	

func _on_bottom_body_entered(body: Node2D) -> void:
	if body is Player:
		if itemCount != 0:
			if itemType == _ITEM_TYPES.COIN:
				call_deferred("createCoin")
			
			itemCount -= 1
		if itemCount == 0:
			animation.play("empty")
			
			
	
