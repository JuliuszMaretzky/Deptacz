extends Area2D

@onready var evil_seed = $evil_seed
@onready var evil_seedling = $evil_seedling
@onready var evil_tentacle = $evil_tentacle

@onready var timer = $Timer
var game_manager
var actualTile = null
var growthStages = []
var growthStageIndex = 0
var canSpread = false
var growthStageCooldown = 5
var spreadSeedCooldown = 2

func _ready():
	timer.wait_time = growthStageCooldown
	timer.start()
	growthStages.append(evil_seed)
	growthStages.append(evil_seedling)
	growthStages.append(evil_tentacle)
	
func _on_area_entered(area:Gardener):
	if evil_seed.visible:
		actualTile.isPlanted = false
		queue_free()
	else:
		area.getDamage(growthStageIndex)

func _on_timer_timeout():
	if !canSpread:
		growthStages[growthStageIndex].visible = false
		growthStageIndex += 1
		growthStages[growthStageIndex].visible = true
		if(growthStageIndex < growthStages.size() - 1):
			timer.start()
		else:
			canSpread = true
			timer.wait_time = spreadSeedCooldown
			timer.start()
	else:
		throwSeed()
		timer.start()
		
func throwSeed():
	var tilesToSpread = []
	for tile in actualTile.neighbors:
		if !tile.isPlanted:
			tilesToSpread.append(tile)
	if tilesToSpread.size() < 1:
		return
	var indexToSpread = randi() % tilesToSpread.size()
	game_manager.plantEvilSeed(tilesToSpread[indexToSpread])
	
