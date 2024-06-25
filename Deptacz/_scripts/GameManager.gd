extends Node2D

@export var gardener: Gardener

@onready var camera = %Camera2D
var tile_basic = preload("res://_scenes/tile_basic.tscn")
var evil_seed = preload("res://_scenes/evil_plant.tscn")
var lawnWidth := 5
var lawnHeight := 5
var lawn = []

func _ready():
	createLawn(lawnWidth,lawnHeight)
	summonGardener()
	plantEvilSeed(Vector2(0,0))
	gardener.canMove = true

func createLawn(width: int, height: int):
	for i in width:
		lawn.append([])
		for j in height:
			var instance = tile_basic.instantiate()
			instance.position = properVector(Vector2(i, j))
			add_child(instance)
			lawn[i].append(instance)
	
	camera.position = properVector(Vector2((width - 1)/2, (height - 1)/2))

func summonGardener():
	gardener.actualTileCoords = Vector2(lawnWidth - 1, lawnHeight - 1)
	gardener.position = lawn[lawnWidth-1][lawnHeight-1].position
	
func properVector(position: Vector2):
	return Vector2(128 * position.x, 128 * position.y)

func plantEvilSeed(position: Vector2):
	var instance = evil_seed.instantiate()
	instance.position = properVector(position)
	instance.actualTile = lawn[position.x][position.y]
	instance.actualTile.isPlanted = true
	add_child(instance)
