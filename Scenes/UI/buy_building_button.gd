extends Button
@export var building_instance: PackedScene

var building: Building
var tile: Tile
var parentUi
var parentWindow
var buildingContainer

func _ready():
	parentUi = find_parent("UI")
	parentWindow = find_parent("SelectBuildingType")
	buildingContainer = parentUi.get_parent().get_node_or_null("BuildingContainer")
	if building:
		self.text = building.name  # Correctly assigning the building's name
	else:
		self.text = "Unnamed Building"  # Fallback in case building is null


func _on_pressed():
	tile.building = building
	var new_building_instance = building_instance.instantiate()
	new_building_instance.building = building
	new_building_instance.tile = tile
	buildingContainer.add_child(new_building_instance)
	print(tile.building.name, " bought")
	parentUi.set_window_close()
	parentWindow.queue_free()
