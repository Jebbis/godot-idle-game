extends Node

var game_data: GAMEDATA
const SAVEPATH: String = "C://Users//lasse//gameDataSave.tres"

var COIN = preload("res://resources/resourceItems/coin.tres")
var FOOD = preload("res://resources/resourceItems/food.tres")
var HERB = preload("res://resources/resourceItems/herb.tres")
var ORE = preload("res://resources/resourceItems/ore.tres")
var WOOD = preload("res://resources/resourceItems/wood.tres")
var starting_inventory: Array = [WOOD, FOOD, ORE, HERB, COIN]

func get_inventory(): 
	return game_data.inventory if game_data else null


func add_item(item: ResourceItem, amount: int = 1):
	game_data.inventory.add_item(item, amount)
	get_tree().call_group("inventory_ui", "refresh")
	save_data()


func get_item_total_amount(item_to_find: String):
	for item in game_data.inventory.items:
		if item.item.item_name == item_to_find:
			return item.amount
	return 0


func _ready():
	load_data()


func save_data() -> void:
	if game_data:
		ResourceSaver.save(game_data, SAVEPATH)


func load_data():
	if ResourceLoader.exists(SAVEPATH):
		game_data = load(SAVEPATH) as GAMEDATA
		return game_data.inventory
	else:
		print("New game data created")
		create_new_game_data()
		return game_data.inventory


func create_new_game_data():
	game_data = GAMEDATA.new()
	game_data.inventory = ResourceInventory.new()
	save_data()
	init_starting_inventory()


func init_starting_inventory():
	for item in starting_inventory:
		var resourceInventoryItem = ResourceInventoryItem.new()
		resourceInventoryItem.item = item
		resourceInventoryItem.amount = 0
		game_data.inventory.items.append(resourceInventoryItem)
	
