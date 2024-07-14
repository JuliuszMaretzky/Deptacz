class_name Gardener
extends Area2D

@onready var game_manager = %GameManager
@export var speed = 300
var direction = Vector2.ZERO

func _process(delta):
	moveGardener(delta)
	
func moveGardener(delta):
	direction = Vector2.ZERO
	if Input.is_action_pressed("moveUp"):
		direction += Vector2(0, -1)
	if Input.is_action_pressed("moveDown"):
		direction += Vector2(0, 1)
	if Input.is_action_pressed("moveLeft"):
		direction += Vector2(-1, 0)
	if Input.is_action_pressed("moveRight"):
		direction += Vector2(1, 0)
			
	translate(direction * speed * delta)
	if position.x > game_manager.lawn[game_manager.lawnWidth-1][0].position.x:
		position.x = game_manager.lawn[game_manager.lawnWidth-1][0].position.x
	if position.x < game_manager.lawn[0][0].position.x:
		position.x = game_manager.lawn[0][0].position.x
	if position.y > game_manager.lawn[0][game_manager.lawnHeight-1].position.y:
		position.y = game_manager.lawn[0][game_manager.lawnHeight-1].position.y
	if position.y < game_manager.lawn[0][0].position.y:
		position.y = game_manager.lawn[0][0].position.y
