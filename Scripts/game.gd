extends Node2D

var score = 0
var addScore
var label
var scoreLabel
var deathText

func _ready() -> void:
	addScore = true
	label = get_node("Player/Camera/HUD/Label")
	label.visible = true
	scoreLabel = get_node("Player/Camera/HUD/scoreLabel")
	scoreLabel.visible = true
	deathText = get_node("Player/Camera/HUD/deathText")
	
func _process(delta: float) -> void:
	if addScore and  $"Player".playerDead == false:
		updateScore()
	if $"Player".playerDead == true:
		label.visible = false
		scoreLabel.visible = false
		deathText.text = "You have Crashed
Score: " + str(score) + "
Press SPACE to try again"
		deathText.visible = true
		
	scoreLabel.text = str(score)
	resetScene()


func updateScore():
	score = score + 1
	addScore = false
	await get_tree().create_timer(1).timeout
	addScore = true
	
func flagScore(points):
	score = score + points

func resetScene():
	if Input.is_action_just_pressed("space") and $"Player".playerDead == true:
		get_tree().reload_current_scene()
