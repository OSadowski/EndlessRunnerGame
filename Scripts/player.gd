extends CharacterBody2D

var HorizontalSpeed = 150
var VerticalSpeed

var playerDead
var increaseSpeed

@onready var flagSound = $"../Sounds/FlagPointSound"
@onready var music = $"../Sounds/Music"
@onready var gameOver = $"../Sounds/GameOver"

func _ready() -> void:
	VerticalSpeed = 10000
	playerDead = false
	increaseSpeed = true

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * HorizontalSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, HorizontalSpeed)
	
	velocity.y = VerticalSpeed * delta
	
	if increaseSpeed and !playerDead:
		speedIncrease()
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.collision_layer)
	if body.collision_layer == 2:
		playerDead = true
		music.playing = false
		gameOver.play()
		HorizontalSpeed = 0
		VerticalSpeed = 0

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.collision_layer == 4:
		$"../Levels".destroyLastLevel()
		$"../Levels".spawnSetUp()
	if area.collision_layer == 16:
		get_parent().flagScore(10)
		flagSound.play()
		area.get_parent().queue_free()

func speedIncrease():
	VerticalSpeed = VerticalSpeed + 500
	increaseSpeed = false
	await get_tree().create_timer(5).timeout
	increaseSpeed = true
	
