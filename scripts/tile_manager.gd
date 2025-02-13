extends Node

signal new_tile(coords: Vector2i, source_id: int, atlas_coords: Vector2i)

var world_tiles: WorldTiles

const SAVEPATH: String = "C://Users//lasse//save.tres"

func _ready():
	if FileAccess.file_exists(SAVEPATH):
		world_tiles = load(SAVEPATH) as WorldTiles


func change_tile(coords: Vector2i, source_id: int, atlas_coords: Vector2i):
	call_deferred("emit_signal", "new_tile", coords, source_id, atlas_coords)


func buy_new_tile(clicked_tile: Vector2i):
	for tile in world_tiles.tiles:
		if tile.position == clicked_tile:
			tile.set_tile_bought(true)
			change_tile(tile.position, 1, tile.atlas_coordinates)
			break


func load_bought_tiles():
	for tile in world_tiles.tiles:
		if tile.tile_bought == true:
			tile.change_tile(tile.position, 1, tile.atlas_coordinates)

	ResourceSaver.save(world_tiles, SAVEPATH)
	print("World saved with ", world_tiles.tiles.size(), " tiles")


func surrounding_tiles_visibility(tile_position: Vector2i, tilemap: TileMapLayer):
	var visible_tiles = tilemap.get_surrounding_cells(tile_position)
	print("clicked tiles surrounding tiles: ",visible_tiles)
	
	for tile in world_tiles.tiles:
		if tile.position in visible_tiles:
			print("Tarkista miksi ei näy viereiset tilet shadow tileinä vaikka ostettu")
			print(tile.tile_visible, " ",tile.position, " ",tile.tile_bought)
			if tile.tile_visible == false and tile.tile_bought == false:
				tile.set_tile_visible(true)
				print(tile.tile_visible, tile.position)
				change_tile(tile.position, 2, tile.atlas_coordinates)
