extends Camera2D

#Aquí se declara una variable tilemap de tipo TileMap y se exporta para que pueda ser asignada en el editor de Godot.

@export var tilemap : TileMap

#Aquí se establece el tamaño de la pantalla como una constante SCREEN_SIZE y se define la posición inicial de current_screen.

const SCREEN_SIZE := Vector2(240, 135)
var current_screen := Vector2(0, 0)


#La función _ready() se llama automáticamente cuando el nodo al que está
# adjunto el script se ha añadido al árbol de escena. 
#En esta función, se obtiene el rectángulo que abarca todas las celdas 
#utilizadas en el TileMap, se calculan las coordenadas de 
#las esquinas superior izquierda e inferior derecha del área visible 
#en unidades de mundo, se establecen los límites de la cámara 
#en las coordenadas calculadas

func _ready(): 
#Lo azul es para que la camara siga al player y los limites sean el 
#tilemap y ese limite se actualize si hay mas tile map
	var visibleArea = tilemap.get_used_rect()
	var tileSize = tilemap.rendering_quadrant_size
	var upperLeftCorner = visibleArea.position * tileSize
	var lowerRightCorner = (visibleArea.position + visibleArea.size) * tileSize
	
	limit_left = tilemap.position.x + upperLeftCorner.x
	limit_top = tilemap.position.y + upperLeftCorner.y
	limit_right = tilemap.position.x + lowerRightCorner.x
	limit_bottom = tilemap.position.y + lowerRightCorner.y
	
#se desacopla la posición de la cámara de su nodo padre, se establece 
#su posición global a la del nodo padre y se actualiza la pantalla.

	set_as_top_level(true)
	global_position = get_parent().global_position
	_update_screen(current_screen)


#La función _physics_process(delta) se llama en cada fotograma de 
#la física. Aquí, se calcula la posición de la pantalla del nodo padre y, 
#si no es aproximadamente igual a la pantalla actual, se actualiza la pantalla.

func _physics_process(delta):
	var parent_screen : Vector2 = (get_parent().global_position / SCREEN_SIZE).floor()
	if not parent_screen.is_equal_approx(current_screen):
		_update_screen(parent_screen)

#Finalmente, la función _update_screen(new_screen : Vector2) 
#actualiza la pantalla actual y la posición global de la cámara.

func _update_screen(new_screen : Vector2):
	current_screen = new_screen
	global_position = current_screen * SCREEN_SIZE + SCREEN_SIZE * 0.5

