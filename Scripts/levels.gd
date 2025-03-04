extends Node2D

var level1 = preload("res://Scenes/levels/level_1.tscn")
var level2 = preload("res://Scenes/levels/level_2.tscn")
var level3 = preload("res://Scenes/levels/level_3.tscn")
var level4 = preload("res://Scenes/levels/level_4.tscn")

var currentEndPoint
var skipFirstDestroy = true

func _ready() -> void:
	currentEndPoint = get_node("level_1/EndPoint").global_position
	Spawn(currentEndPoint)

func spawnSetUp():
	Spawn(get_child(-1).get_child(1).global_position)

func Spawn(startPoint):
	var currentLevel = null
	var nextLevel = getRandomLevel()
	if nextLevel == 1:
		currentLevel = level1.instantiate()
	elif nextLevel == 2:
		currentLevel = level2.instantiate()
	elif nextLevel == 3:
		currentLevel = level3.instantiate()
	elif nextLevel == 4:
		currentLevel = level4.instantiate()
	add_child(currentLevel)
	currentLevel.global_position = startPoint

func destroyLastLevel():
	if !skipFirstDestroy:
		var oldestLevel = get_child(0)
		oldestLevel.queue_free()
	skipFirstDestroy = false


func getRandomLevel():
	var rng = RandomNumberGenerator.new()
	var random_number = rng.randi_range(1, 4)
	return random_number
	
