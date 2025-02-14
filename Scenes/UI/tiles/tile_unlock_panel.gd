extends Panel

@onready var label = $VBoxContainer/Label

var parent
var tilemap: TileMapLayer
var tile: Tile

func _ready():
	parent = get_parent()
	label.text = Tile.TileType.keys()[tile.tile_type]


func _on_buy_tile_button_pressed():
	TileManager.buy_new_tile(tile.position)
	TileManager.surrounding_tiles_visibility(tile.position)
	parent.set_window_close()
	self.queue_free()


func _on_close_button_pressed():
	parent.set_window_close()
	self.queue_free()
