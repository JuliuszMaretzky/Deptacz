extends Area2D

@onready var evil_seed = $evil_seed
@onready var evil_seedling = $evil_seedling
@onready var evil_tentacle = $evil_tentacle


@onready var timer = $Timer
var actualTile = null
var growthStages = []
var growthStageIndex = 0

func _ready():
	timer.wait_time = 3
	timer.start()
	growthStages.append(evil_seed)
	growthStages.append(evil_seedling)
	growthStages.append(evil_tentacle)
	print("start: " + str(growthStageIndex))

func _on_area_entered(area):
	print(actualTile.isPlanted)
	actualTile.isPlanted = false
	print(actualTile.isPlanted)
	queue_free()

func _on_timer_timeout():
	growthStages[growthStageIndex].visible = false
	growthStageIndex += 1
	growthStages[growthStageIndex].visible = true
	if(growthStageIndex < growthStages.size() - 1):
		timer.start()
