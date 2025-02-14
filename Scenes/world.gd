extends Node2D

@onready var ground: TileMapLayer = $Tiles/Ground

func _ready():
	pass


func _exit_tree() -> void:
	TileManager.save_data()
