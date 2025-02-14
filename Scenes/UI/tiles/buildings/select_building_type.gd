extends Control

@onready var label = $Panel/HBoxContainer/Label
@onready var h_box_container = $Panel/HBoxContainer
@onready var close_button = $Panel/HBoxContainer/CloseButton

var BUILDING_DATABASE = preload("res://resources/buildings/building_database.tres")
var buy_building_button = preload("res://Scenes/UI/tiles/buildings/buy_building_button.tscn")

var tile: Tile
var parent
var allowed_buildings

func _ready():
	parent = get_parent()
	label.text = Tile.TileType.keys()[tile.tile_type]
	allowed_buildings = BUILDING_DATABASE.buildings
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
	parent.set_window_close()
	self.queue_free()
