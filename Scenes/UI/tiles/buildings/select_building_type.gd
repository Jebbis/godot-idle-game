extends Control

@onready var h_box_container = $Panel/HBoxContainer
@onready var close_button = $Panel/HBoxContainer/CloseButton
@onready var tile_type_name = %TileTypeName
@onready var tile_property_name = %TilePropertyName

var BUILDING_DATABASE = preload("res://resources/buildings/building_database.tres")
var buy_building_button = preload("res://Scenes/UI/tiles/buildings/buy_building_button.tscn")

var tile: Tile
var UI_parent
var allowed_buildings: Array = []

func _ready():
	UI_parent = find_parent("UI")
	tile_type_name.text = Tile.TileType.keys()[tile.tile_type]
	tile_property_name.text = Tile.TileProperty.keys()[tile.tile_property]
	
	#Check if this tile tpye and tile property combination have buildings with same combinations
	for building in BUILDING_DATABASE.buildings:
		var allowed_tile_types = building.allowed_tile_type.map(func(value): return Building.AllowedTileType.keys()[value])
		var allowed_tile_properties = building.allowed_tile_property.map(func(value): return Building.AllowedTileProperty.keys()[value])
		if Tile.TileType.keys()[tile.tile_type] in allowed_tile_types and Tile.TileProperty.keys()[tile.tile_property] in allowed_tile_properties:
			allowed_buildings.append(building)
	create_buttons_for_buildings()


func create_buttons_for_buildings():
	if tile.building:
		return
		
	for building in allowed_buildings:
		var new_building_build_button = buy_building_button.instantiate()
		new_building_build_button.tile = tile
		new_building_build_button.building = building
		h_box_container.add_child(new_building_build_button)
	h_box_container.move_child(close_button, h_box_container.get_child_count() - 1)


func _on_close_button_pressed():
	UI_parent.set_window_close()
	get_parent().set_bg_shadow()
	self.queue_free()
