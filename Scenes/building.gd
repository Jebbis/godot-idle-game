extends Node2D
class_name BuildingInstance

@export var building: Building  # Reference to the Building resource
@export var tile: Tile  # Reference to the tile this building is on
@onready var building_texture = $Sprite2D

var timer: Timer

func _ready():
	if building and building.output_item and building.output_amount and building.interval:
		timer = Timer.new()
		timer.wait_time = building.interval
		timer.autostart = true
		timer.timeout.connect(_produce)
		building_texture.texture = building.icon
		building_texture.scale.x = 0.234
		building_texture.scale.y = 0.234
		building_texture.position = tile.position*17
		add_child(timer)

func _produce():
	if building and building.output_item and building.output_amount and building.interval:
		print(building.name, " produced ", building.output_amount, " ", building.output_item.item_name, " at tile: ", tile.position)
		InventoryManager.add_item(building.output_item, building.output_amount)  # Add to inventory
