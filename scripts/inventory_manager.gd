extends Node


const inventory = preload("res://resources/inventory/resource_inventory.tres")

func add_item(item: ResourceItem, amount: int = 1):
	inventory.add_item(item, amount)
	get_tree().call_group("inventory_ui", "refresh")  # Update all inventory UI elements
