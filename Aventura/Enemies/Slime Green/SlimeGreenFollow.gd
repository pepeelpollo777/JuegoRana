extends CharacterBody2D

var startPosition
var endPosition
var SPEED = 25
var limit = 0.5
var knockbackForce = 500
var isDead = false
var playerPosition = Vector2()
var isFollowing = false
@onready var player = $"../../Player"
@onready var animations = $AnimatedSprite2D
@onready var damage = 1

func _ready():
	pass

func getPlayerPosition():
	pass

func updateVelocity():
	if isFollowing:
		playerPosition = player.global_position
		var direction = (playerPosition - position).normalized()
		velocity = direction * SPEED
		move_and_slide()

func updateAnims():
	if velocity.y < 0:
		animations.play("WalkU")
	elif velocity.y > 0:
		animations.play("WalkD")
	elif velocity.x > 0:
		animations.play("WalkR")
	elif velocity.x < 0:
		animations.play("WalkL")


func _physics_process(delta):
	if isDead: return
	updateVelocity()
	updateAnims()


func _on_hit_box_area_entered(area):
	pass


func _on_hurt_box_area_entered(area):
	if area == $hitBox: return
	$hitBox.set_deferred("monitorable",false)
	isDead = true
	animations.play("death")
	await animations.animation_finished
	queue_free()



func _on_follow_area_area_entered(area):
	if area.name == "Detect":
		isFollowing = true


func _on_follow_area_area_exited(area):
	if area.name == "Detect":
		isFollowing = false
