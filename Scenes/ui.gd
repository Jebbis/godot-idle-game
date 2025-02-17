extends CanvasLayer

@export var tile_unlock_panel: PackedScene
@export var tile_building_type: PackedScene
@onready var ui_overlay = $UIOverlay

var window_open: bool = false
var popup_window

func _ready():
	popup_window = ui_overlay.find_child("Popup")

func open_tile_unlock_panel(tile: Tile, tilemap: TileMapLayer):
	if window_open:
		return

	var tile_unlock_panel_instance = tile_unlock_panel.instantiate()
	tile_unlock_panel_instance.tile = tile
	tile_unlock_panel_instance.tilemap = tilemap
	add_child(tile_unlock_panel_instance)
	window_open = true


func open_tile_building_selection(tile: Tile):

	if window_open:
		return

	var tile_building_type_instance = tile_building_type.instantiate()
	tile_building_type_instance.tile = tile
	popup_window.add_child(tile_building_type_instance)
	popup_window.set_bg_shadow()
	window_open = true
	
func set_window_open():
	window_open = true

func set_window_close():
	window_open = false
