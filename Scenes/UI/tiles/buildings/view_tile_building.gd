extends Control
@onready var building_icon = %BuildingIcon
@onready var building_name = %BuildingName
@onready var building_level = %BuildingLevel

var tile: Tile

func set_properties(building_tile: Tile):
	tile = building_tile
	print(tile.building.name)
	building_icon.texture = tile.building.icon
	building_name.text = tile.building.name
	building_level.text = str("level ",tile.building.level)


func _on_upgrade_building_pressed():
	var new_level = tile.building.level + 1
	tile.building.level = new_level
	building_level.text = str("level ",new_level)


func _on_close_button_pressed():
	find_parent("UI").set_window_close()
	get_parent().set_bg_shadow()
	self.queue_free()
