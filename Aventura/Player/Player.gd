extends CharacterBody2D

var dir:Vector2 = Vector2.ZERO
var dirDash
var normalSpeed:int = 55
var dashSpeed:int = 105
var dashDuration:float = 0.3
var cooldDown = 1000
var lastDash= Time.get_ticks_msec()
@export var maxHealth = 3
@export var inventory: Inventory
@onready var animations = $Anims
@onready var weapon = $Weapon
@onready var effects = $Effects
@onready var hurtBox = $hurtBox
@onready var hurtTimer = $HurtTimer
@onready var health = maxHealth
@onready var slime = $"../Slimes/SlimeGreenPoint"
@onready var slimeFollow = $"../Slimes/SlimeGreenFollow"
@onready var knockBackSwordForce = 300
@onready var sword: PackedScene
var lastAnimDirection = "Down"
var isAttacking = false
var isHurt = false
var swordEquipped = false
var isRuning = false
var speedMult = 1.3
signal healthChanged

func _ready():
	sword = preload("res://Player/sword.tscn")

func movementPlayer():
#mover
	var speed = normalSpeed
	
	if Input.is_action_pressed("sprint"):
		speed *= speedMult
	
	dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	
#dash
	if(isDashing()):
		speed = dashSpeed
		dir = dirDash
	velocity = dir.normalized() * speed
	move_and_slide()

func isDashing():
	return not $DashTimer.is_stopped()

func startDash():
	var timeNow = Time.get_ticks_msec()
	if (timeNow - lastDash) < cooldDown:
		return
	dirDash = dir
	lastDash = timeNow
	$DashTimer.wait_time = dashDuration
	$DashTimer.start()

func _input(event):
	if Input.is_action_just_pressed("dash"):
		startDash()


func attack():
	if Input.is_action_just_pressed("attack"):
		animations.play("attack" + lastAnimDirection)
		isAttacking = true
		weapon.enable()
		await animations.animation_finished
		weapon.disable()
		isAttacking = false


func animCtrl():
	if isAttacking: return
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
	
		animations.play("walk" + direction)
		lastAnimDirection = direction


func handleCollision():
	for i in get_slide_collision_count():
		var collison = get_slide_collision(i)
		var collider = collison.get_collider()

func _physics_process(delta):
	handleCollision()
	movementPlayer()
	animCtrl()
	attack()
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "hitBox":
				hurtByEnemy(area)


func hurtByEnemy(area):
	health -= slime.damage
	if health < 0:
		health = maxHealth
			
	healthChanged.emit(health)
	isHurt = true
		
	knockback(area.get_parent().velocity)
	effects.play("HurtBlink")
	hurtTimer.start()
	await hurtTimer.timeout
	effects.play("RESET")
	isHurt = false

func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)


func knockback(enemieVelocity: Vector2):
	var knockbackDirection = (enemieVelocity - velocity).normalized() * slime.knockbackForce
	velocity = knockbackDirection
	move_and_slide()




func _on_hurt_box_area_exited(area):
	pass


