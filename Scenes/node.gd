extends Node

signal new_tile(coords: Vector2i, source_id: int, atlas_coords: Vector2i)

func change_tile(coords: Vector2i, source_id: int, atlas_coords: Vector2i):
	call_deferred("emit_signal", "new_tile", coords, source_id, atlas_coords)
