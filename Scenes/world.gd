extends Node2D

@onready var ground: TileMapLayer = $Tiles/Ground

var world_tiles: WorldTiles
var TileMapTiles

const SAVEPATH: String = "C://Users//lasse//save.tres"

func _ready():
	TileMapTiles = ground.get_used_cells()
	print(TileMapTiles)
	world_tiles = load_data()

	TileManager.load_bought_tiles()
	TileManager.surrounding_tiles_visibility(Vector2i(0,0), ground)


func save_data() -> void:
	ResourceSaver.save(world_tiles, SAVEPATH)


func load_data():
	if ResourceLoader.exists(SAVEPATH): 
		return load(SAVEPATH)
	else:
		print("new save")
		world_tiles = WorldTiles.new()
		for cell in TileMapTiles:  # Loop through generated tiles
			var tile = Tile.new()
			var tileAtlasCoordinates = ground.get_cell_atlas_coords(cell)
			tile.position = cell
			tile.atlas_coordinates = tileAtlasCoordinates
			tile.initialize_tile_type(tileAtlasCoordinates)
			if cell == Vector2i(0,0):
				tile.tile_property = tile.TileProperty.RIVER
				tile.set_tile_bought(true)
				tile.set_tile_visible(true)
			world_tiles.tiles.append(tile)
		save_data()
		return world_tiles


func _exit_tree() -> void:
	save_data()
