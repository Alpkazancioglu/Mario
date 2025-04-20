extends CharacterBody2D
class_name Player

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label


enum MARIO_STATES {SMALL,BIG,SHOOTING,INVINCIBLE}

const SPEED = 140
const MAX_SPEED: int = 180
const JUMP_VELOCITY = -370.0


var translating: bool = false
var marioState: MARIO_STATES = MARIO_STATES.SMALL
var states: Dictionary
var currentState: State
var prevState: State
var direction: Vector2
var leftBorder: int = 0
var health: int = 1



func _ready() -> void:
	for child in $states.get_children():
		if child is State:
			states[child.name] = child
			states[child.name].player = self
			
	for state in states.values():
		state.states = states
	
	currentState = states["idle"]
	prevState = states["idle"]
	currentState.enter()
	
	health = 1


func turnInvincibleMario(prevState: MARIO_STATES) -> void:
	pass

func turnShootingMario(prevState: MARIO_STATES) -> void:
	pass

func turnBigMario(prevState: MARIO_STATES) -> void:
	if prevState == MARIO_STATES.SMALL:
		pass
	
func turnSmallMario(prevState: MARIO_STATES) -> void:
	pass



## Flips the sprite to player last direction
func flipSprite() -> void:
	if direction.x == 1:
		animation.flip_h = false
	elif direction.x == -1:
		animation.flip_h = true


func _physics_process(delta: float) -> void:
	
	if translating == false:
		changeStates(currentState.update(delta))
		label.text = currentState.name
		
		
		move_and_slide()

func _process(delta: float) -> void:
	handleInput()


func handleInput() -> void:
	direction = Vector2.ZERO
	direction.x = Input.get_axis("moveLeft","moveRight")
	if Input.is_action_pressed("jump"):
		direction.y = 1
	elif velocity.y > 0:
		direction.y = -1


func applyGravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func playAnim(name: String) -> void:
	if marioState == MARIO_STATES.SMALL:
		animation.play(name)
	elif marioState == MARIO_STATES.BIG:
		name = "big_%s" % [name]
		animation.play(name)
	
	if name != animation.animation:
		printerr("desired anim %s : playingAnim %s" % [name,animation.animation])
	

func changeStates(inputState: State) -> void:
	if inputState != currentState:
		prevState = currentState
		currentState = inputState
		prevState.exit()
		currentState.enter()
