extends Node2D

@onready var ground = $"../Tiles/Ground"
@onready var ui = $"../UI"

var outline_tile_pos = Vector2i(-1, -1)  # Keeps track of the current highlighted tile
var outline_sprite = null  # Reference to the outline sprite

func _ready():
	# Create an outline sprite and add it to the node
	outline_sprite = Sprite2D.new()
	outline_sprite.texture = preload("res://Assets/outline.png")  # Load outline texture
	outline_sprite.modulate = Color(1, 1, 1, 0.7)  # Semi-transparent
	outline_sprite.visible = false  # Hidden initially
	add_child(outline_sprite)

func _process(_delta):
	update_outline()

func update_outline():
	if ui.window_open:
		return
	var tile_pos = ground.local_to_map(get_global_mouse_position())  # Get tile position under mouse

	# Only update if the hovered tile has changed
	if tile_pos != outline_tile_pos:
		outline_tile_pos = tile_pos
		
		if ground.get_cell_atlas_coords(tile_pos) != Vector2i(-1, -1):  # If it's a valid tile
			outline_sprite.visible = true
			outline_sprite.position = ground.map_to_local(tile_pos)  # Align to grid
		else:
			outline_sprite.visible = false
