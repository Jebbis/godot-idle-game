extends Node

var inventory: ResourceInventory
const SAVEPATH: String = "C://Users//lasse//inventorySave.tres"

var COIN = preload("res://resources/resourceItems/coin.tres")
var FOOD = preload("res://resources/resourceItems/food.tres")
var HERB = preload("res://resources/resourceItems/herb.tres")
var ORE = preload("res://resources/resourceItems/ore.tres")
var WOOD = preload("res://resources/resourceItems/wood.tres")
var starting_inventory: Array = [WOOD, FOOD, ORE, HERB, COIN]

func get_inventory(): return inventory


func add_item(item: ResourceItem, amount: int = 1):
	inventory.add_item(item, amount)
	get_tree().call_group("inventory_ui", "refresh")


func get_item_total_amount(item_to_find: String):
	for item in inventory.items:
		if item.item.item_name == item_to_find: 
			return item.amount


func _ready():
	load_data()


func save_data() -> void:
	ResourceSaver.save(inventory, SAVEPATH)


func load_data():
	if ResourceLoader.exists(SAVEPATH): 
		inventory = load(SAVEPATH)
		return load(SAVEPATH)
	else:
		print("new inventory created")
		inventory = ResourceInventory.new()
		save_data()
		init_starting_inventory()
		return inventory

func init_starting_inventory():
	for item in starting_inventory:
		var resourceInventoryItem = ResourceInventoryItem.new()
		resourceInventoryItem.item = item
		resourceInventoryItem.amount = 0
		inventory.items.append(resourceInventoryItem)
	
