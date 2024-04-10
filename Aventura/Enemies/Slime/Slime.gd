extends CharacterBody2D

var startPosition
var endPosition
var SPEED = 20
var limit = 0.5
var knockbackForce = 500
var isDead = false
@export var endPoint: Marker2D
@onready var animations = $AnimatedSprite2D
@onready var damage = 1

func _ready():
	startPosition = position
	endPosition = endPoint.global_position

func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
	velocity = moveDirection.normalized() * SPEED
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

