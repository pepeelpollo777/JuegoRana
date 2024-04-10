extends Area2D

@onready var shape = $CollisionShape2D
@onready var knockBackForce = 300
var isPickedUp = false
signal PickSword

func enable():
	shape.disabled = false

func disable():
	shape.disabled = true


