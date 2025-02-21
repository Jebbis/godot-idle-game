extends Node

signal new_tile(coords: Vector2i, source_id: int, atlas_coords: Vector2i)

const building_instance = preload("res://Scenes/building.tscn")

var game_data: GAMEDATA
var tilemap: TileMapLayer

const SAVEPATH: String = "C://Users//lasse//gameDataSave.tres"

func change_tile(coords: Vector2i, source_id: int, atlas_coords: Vector2i):
	call_deferred("emit_signal", "new_tile", coords, source_id, atlas_coords)

func buy_new_tile(clicked_tile: Vector2i):
	for tile in game_data.tiles.tiles:
		if tile.position == clicked_tile:
			tile.set_tile_bought(true)
			change_tile(tile.position, 1, tile.atlas_coordinates)
			break 
	save_data()

func load_bought_tiles():
	var buildingContainer = get_tree().current_scene.get_node_or_null("BuildingContainer")
	for tile in game_data.tiles.tiles:
		if tile.tile_bought:
			tile.change_tile(tile.position, 1, tile.atlas_coordinates)
			surrounding_tiles_visibility(tile.position)
			if tile.building:
				load_bought_buildings(tile, buildingContainer)

	ResourceSaver.save(game_data, SAVEPATH)
	print("World saved with ", game_data.tiles.tiles.size(), " tiles")

func surrounding_tiles_visibility(tile_position: Vector2i):
	var visible_tiles = tilemap.get_surrounding_cells(tile_position)
	
	for tile in game_data.tiles.tiles:
		if tile.position in visible_tiles:
			if tile.tile_bought == false:
				tile.set_tile_visible(true)
				print("Setting tile shadow visible at: ", tile.position)
				change_tile(tile.position, 2, tile.atlas_coordinates)

func set_tilemap(tilemaplayer: TileMapLayer):
	tilemap = tilemaplayer

func save_data() -> void:
	if game_data:
		ResourceSaver.save(game_data, SAVEPATH)

func load_data():
	if ResourceLoader.exists(SAVEPATH): 
		game_data = load(SAVEPATH) as GAMEDATA
		if not game_data.tiles:
			create_new_game_data()
		load_bought_tiles()
		return load(SAVEPATH).tiles
	else:
		game_data = GAMEDATA.new()
		print("new tiles created")
		create_new_game_data()
		return game_data.tiles


func create_new_game_data():
	game_data.tiles = WorldTiles.new()
	save_data()
	init_starting_position()
	surrounding_tiles_visibility(Vector2i(0, 0))
	

func init_starting_position():
	var TileMapTiles = tilemap.get_used_cells()
	for cell in TileMapTiles:
		var tile = Tile.new()
		var tileAtlasCoordinates = tilemap.get_cell_atlas_coords(cell)
		tile.position = cell
		tile.atlas_coordinates = tileAtlasCoordinates
		tile.initialize_tile_type(tileAtlasCoordinates)
		if cell == Vector2i(0, 0):
			tile.tile_property = tile.TileProperty.PLAIN
			tile.set_tile_bought(true)
			tile.set_tile_visible(true)
		game_data.tiles.tiles.append(tile)

func load_bought_buildings(tile: Tile, buildingContainer: Node2D):
	var new_building_instance = building_instance.instantiate()
	new_building_instance.building = tile.building
	new_building_instance.tile = tile
	print(buildingContainer)
	buildingContainer.add_child(new_building_instance)
	print(tile.building.name, " loaded to tile: ", tile.position)
