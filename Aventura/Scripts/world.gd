extends Node2D
@onready var heartsContainer = $CanvasLayer/HeartsContainer
@onready var player = $TileMap/Player

func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.health)
	player.healthChanged.connect(heartsContainer.updateHearts)



func _on_inventory_gui_closed():
	get_tree().paused = false

func _on_inventory_gui_opened():
	get_tree().paused = true
