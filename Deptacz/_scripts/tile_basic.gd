extends Area2D

var isPlanted = false
var neighbors = []

func addNeighbor(newNeighbor: Area2D):
	neighbors.append(newNeighbor)
	
