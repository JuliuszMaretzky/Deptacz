extends Node2D

@export var gardener: Gardener

@onready var camera = %Camera2D
var tile_basic = preload("res://_scenes/tile_basic.tscn")
var evil_seed = preload("res://_scenes/evil_plant.tscn")
var lawnWidth := 5
var lawnHeight := 5
var lawn = []

func _ready():
	createLawn()
	summonGardener()
	plantEvilSeed(Vector2(0,0))

func createLawn():
	for i in lawnWidth:
		lawn.append([])
		for j in lawnHeight:
			var instance = tile_basic.instantiate()
			instance.position = properVector(Vector2(i, j))
			add_child(instance)
			lawn[i].append(instance)
	createNeighborhood()
	camera.position = properVector(Vector2((lawnWidth - 1)/2, (lawnHeight - 1)/2))

func summonGardener():
	gardener.position = lawn[lawnWidth-1][lawnHeight-1].position
	
func properVector(position: Vector2):
	return Vector2(128 * position.x, 128 * position.y)

func plantEvilSeed(position: Vector2):
	var instance = evil_seed.instantiate()
	instance.position = properVector(position)
	instance.actualTile = lawn[position.x][position.y]
	instance.actualTile.isPlanted = true
	add_child(instance)
	
func createNeighborhood():
	for i in lawnWidth:
		for j in lawnHeight:
			if i < lawnWidth - 1:
				lawn[i][j].addNeighbor(lawn[i+1][j])
			if i < lawnWidth - 1 && j < lawnHeight - 1:
				lawn[i][j].addNeighbor(lawn[i+1][j+1])
			if(j < lawnHeight - 1):
				lawn[i][j].addNeighbor(lawn[i][j+1])
			if(i > 0 && j < lawnHeight - 1):
				lawn[i][j].addNeighbor(lawn[i-1][j+1])
			if(i > 0):
				lawn[i][j].addNeighbor(lawn[i-1][j])
			if(i > 0 && j > 0):
				lawn[i][j].addNeighbor(lawn[i-1][j-1])
			if(j > 0):
				lawn[i][j].addNeighbor(lawn[i][j-1])
			if(i < lawnWidth - 1 && j > 0):
				lawn[i][j].addNeighbor(lawn[i+1][j-1])
