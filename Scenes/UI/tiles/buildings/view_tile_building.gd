extends Control
@onready var building_icon = %BuildingIcon
@onready var building_name = %BuildingName

var tile: Tile

func set_properties(building_tile: Tile):
	tile = building_tile
	print(tile.building.name)
	building_icon.texture = tile.building.icon
	building_name.text = tile.building.name
