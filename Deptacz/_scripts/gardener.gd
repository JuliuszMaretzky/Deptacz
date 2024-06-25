class_name Gardener
extends Area2D

@onready var game_manager = %GameManager
@export var speed = 300
var canMove = false
var actualTileCoords = Vector2(-1, -1)
var direction = Vector2.ZERO

func _process(delta):
	if !canMove:
		return
		
	moveGardener(delta)
	
func moveGardener(delta):
	var actualTilePosition = game_manager.lawn[actualTileCoords.x][actualTileCoords.y].position
	translate(direction * speed * delta)
	if (actualTilePosition - position).length() < 3:
		direction = Vector2.ZERO
		position = actualTilePosition
		
	if direction == Vector2.ZERO:
		if Input.is_action_pressed("moveUp"):
			if actualTileCoords.y > 0:
				actualTileCoords.y -= 1
				direction += Vector2(0, -1)
		elif Input.is_action_pressed("moveDown"):
			if actualTileCoords.y < game_manager.lawnHeight-1:
				actualTileCoords.y += 1
				direction += Vector2(0, 1)
		elif Input.is_action_pressed("moveLeft"):
			if actualTileCoords.x > 0:
				actualTileCoords.x -= 1
				direction += Vector2(-1, 0)
		elif Input.is_action_pressed("moveRight"):
			if actualTileCoords.x < game_manager.lawnWidth-1:
				actualTileCoords.x += 1
				direction += Vector2(1, 0)
