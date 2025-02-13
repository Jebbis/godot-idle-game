extends Resource
class_name Building

@export var allowed_tile_property: Array[AllowedTileProperty]
@export var allowed_tile_type: AllowedTileType

enum AllowedTileProperty { RIVER, PLAIN, LAKE }
enum AllowedTileType { FOREST, SAND, WATER }

@export var name: String
@export var icon: Texture2D
@export var description: String = ""

@export var output_item: ResourceItem  # Resource type to produce
@export var base_amount: int = 5
@export var output_amount: int = 5
@export var interval: float = 10.0  # Time in seconds per cycle
