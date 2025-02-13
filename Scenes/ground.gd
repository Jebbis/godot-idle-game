extends TileMapLayer

func _ready():
	if TileManager:
		TileManager.new_tile.connect(set_new_tile)
	else:
		print("Tile Manager Not Assigned")


func set_new_tile(coords: Vector2i, source_id: int, atlas_coords: Vector2i):
	set_cell(coords,source_id,atlas_coords)
