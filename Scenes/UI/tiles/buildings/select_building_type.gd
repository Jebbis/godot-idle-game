extends Control

@onready var building_resource = %BuildingResource
@onready var building_resource_amount = %BuildingResourceAmount
@onready var tile_type_name = %TileTypeName
@onready var tile_property_name = %TilePropertyName
@onready var building_container = %BuildingContainer
@onready var margin_carousel_right = %MarginCarouselRight
@onready var building_selection_button = %BuildingSelectionButton
@onready var building_name = %BuildingName

@export var building_instance: PackedScene

var BUILDING_DATABASE: Array[Building] = []
const BUILDING_SELECTION_TEXTURE = preload("res://Scenes/UI/tiles/buildings/building_selection_texture.tscn")

var tile: Tile
var current_building_index: int = 0
var max_building_index: int
var buildings: Array = []

func _ready():
	load_buildings()
	tile_type_name.text = Tile.TileType.keys()[tile.tile_type]
	tile_property_name.text = Tile.TileProperty.keys()[tile.tile_property]
	
	create_buildings_to_ui()


#Updates the currently selected buildings information
func update_selected_building():
	if buildings.size() < 1:
		return
	building_name.text = buildings[current_building_index].name
	building_resource.text = buildings[current_building_index].output_item.item_name
	building_resource_amount.text = str(buildings[current_building_index].output_amount)


#Loads all the buildings to filter from
func load_buildings():
	for file in DirAccess.get_files_at("res://resources/buildings/instances/"):
		var building_file = "res://resources/buildings/instances/" + file
		var building:Building = load(building_file) as Building
		BUILDING_DATABASE.append(building)


#Check if this tile tpye and tile property combination have buildings with same combinations
func get_allowed_buildings():
	var allowed_buildings: Array = []
	for building in BUILDING_DATABASE:
		var allowed_tile_types = building.allowed_tile_type.map(func(value): return Building.AllowedTileType.keys()[value])
		var allowed_tile_properties = building.allowed_tile_property.map(func(value): return Building.AllowedTileProperty.keys()[value])
		if Tile.TileType.keys()[tile.tile_type] in allowed_tile_types and Tile.TileProperty.keys()[tile.tile_property] in allowed_tile_properties:
			allowed_buildings.append(building)
	return allowed_buildings


#Creates building visuals to building carousel
func create_buildings_to_ui():
	if tile.building:
		return
		
	buildings = get_allowed_buildings()
	if buildings.size() < 1:
		return
		
	max_building_index = buildings.size()
	for building in buildings:
		var new_building_texture = BUILDING_SELECTION_TEXTURE.instantiate()
		new_building_texture.texture = building.icon
		building_container.add_child(new_building_texture)
	building_container.move_child(margin_carousel_right, building_container.get_child_count() - 1)
	update_selected_building()


func _on_close_button_pressed():
	find_parent("UI").set_window_close()
	get_parent().set_bg_shadow()
	self.queue_free()


func _on_building_selection_button_pressed():
	if buildings.size() < 1:
		return
	
	var new_building_resource = buildings[current_building_index].duplicate()
	tile.building = new_building_resource
	
	var new_building_instance = building_instance.instantiate()
	new_building_instance.building = new_building_resource
	new_building_instance.tile = tile
	
	find_parent("UI").get_parent().get_node_or_null("BuildingContainer").add_child(new_building_instance)
	print(tile.building.name, " bought")
	
	#Close ui
	find_parent("UI").set_window_close()
	get_parent().set_bg_shadow()
	self.queue_free()
