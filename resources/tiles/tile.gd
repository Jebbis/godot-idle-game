extends Resource
class_name Tile

@export var tile_type: TileType
@export var tile_property: TileProperty = TileProperty.PLAIN
@export var building: Building = null  # Reference to the placed building (optional)
@export var position: Vector2i
@export var atlas_coordinates: Vector2i
@export var tile_bought: bool = false
@export var tile_visible: bool = false

enum TileType { FOREST, SAND, WATER }
enum TileProperty { NONE, RIVER, PLAIN, LAKE}

func set_tile_visible(value: bool):
	tile_visible = value


func initialize_tile_type(atlas_coords: Vector2i):
	match atlas_coords:
		Vector2i(0, 0):
			tile_type = TileType.FOREST
		Vector2i(1, 0):
			tile_type = TileType.SAND
		Vector2i(2, 0):
			tile_type = TileType.WATER

func set_tile_bought(value: bool):
	tile_bought = value


func change_tile(position, source_id: int, atlas_coords: Vector2i):
	if tile_bought == true:
		TileManager.change_tile(position, source_id, atlas_coords)
