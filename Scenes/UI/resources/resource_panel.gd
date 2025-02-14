extends Control

@export var resource_item_panel: PackedScene

@onready var timer = %Timer
@onready var h_box_container = %HBoxContainer

var inventory: ResourceInventory
var resource_instances: Array = []

func _ready():
	inventory = InventoryManager.get_inventory()
	instantiate_resources()


func instantiate_resources():
	for resource in inventory.items:
		var new_resource_panel = resource_item_panel.instantiate()
		h_box_container.add_child(new_resource_panel)
		resource_instances.append(new_resource_panel)
		new_resource_panel.set_resource_data(resource)


func _on_timer_timeout():
	for instance in resource_instances:
		instance.update_resource_data()
