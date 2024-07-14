extends Area2D

var isPlanted = false
var neighors = []

func addNeighbor(newNeighbor: Area2D):
	neighors.append(newNeighbor)
	
