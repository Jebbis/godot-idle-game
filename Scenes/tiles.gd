extends Node2D

@onready var ground = $Ground
@onready var ui = $"../UI"

var world_tiles: WorldTiles


func _ready():
	TileManager.set_tilemap(ground)
	world_tiles = TileManager.load_data()


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var tile_pos: Vector2i = ground.local_to_map(get_global_mouse_position())
		print("clicked tile position: ", tile_pos)
		var tile: Tile
		for world_tile in world_tiles.tiles:
			if world_tile.position == tile_pos:
				tile = world_tile
				break
		if tile and tile.tile_visible == true and tile.tile_bought == false:
			ui.open_tile_unlock_panel(tile, ground)
		if tile and tile.tile_bought == true and tile.tile_visible == true and tile.building == null:
			print(tile.building)
			ui.open_tile_building_selection(tile)
		if tile and tile.tile_bought == true and tile.tile_visible == true and tile.building:
			ui.open_tile_building_view(tile)
