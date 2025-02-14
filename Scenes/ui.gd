extends CanvasLayer

@export var tile_unlock_panel: PackedScene
@export var tile_building_type: PackedScene

var RESOURCE_INVENTORY = preload("res://resources/inventory/resource_inventory.tres")
@onready var label_wood = $HBoxContainer/Wood/LabelWood

var window_open: bool = false

func _process(_delta):
	label_wood.text = str(InventoryManager.get_item_total_amount("Wood"))

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
	add_child(tile_building_type_instance)
	window_open = true
	
func set_window_open():
	window_open = true

func set_window_close():
	window_open = false
