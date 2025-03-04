extends Resource
class_name ResourceInventory

@export var items: Array[ResourceInventoryItem] = []

# Adds an item to the inventory
func add_item(item: ResourceItem, amount: int = 1):
	for inventory_item in items:
		if inventory_item.item == item:
			inventory_item.amount += amount
			print("Total amount of ",inventory_item.item.item_name," ", inventory_item.amount)
			return
	
	# If item doesn't exist, create a new InventoryItem
	var new_inventory_item = ResourceInventoryItem.new()
	new_inventory_item.item = item
	new_inventory_item.amount = amount
	items.append(new_inventory_item)
	print("Total amount of ",new_inventory_item.item.item_name," ", new_inventory_item.amount)
	return 
