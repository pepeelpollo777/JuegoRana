extends Camera2D

# Setting the established screen size as constant and defining the start position of the current_screen

const SCREEN_SIZE := Vector2( 1152, 648)
var current_screen := Vector2( 0, 0 )

# Decouple the camera position from its parent by setting it as "top_level"

func _ready():
	set_as_top_level(true)
	global_position = get_parent().global_position
	_update_screen( current_screen )

# compute the position of the parent normalized and floored to the screen size (same as grid size)

func _physics_process(delta):
	var parent_screen : Vector2 = ( get_parent().global_position / SCREEN_SIZE ).floor()
	if not parent_screen.is_equal_approx( current_screen ):
		_update_screen( parent_screen )

# Updating the camera position. 

func _update_screen(new_screen : Vector2):
	current_screen = new_screen
	global_position = current_screen * SCREEN_SIZE + SCREEN_SIZE * 0.1	
