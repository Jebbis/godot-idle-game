extends Control

@onready var scroll_container = %ScrollContainer
@onready var building_container = %BuildingContainer

var target_scroll: int = 0
var index: int = 0
var parent

func _ready() -> void:
	_set_selection()
	parent = get_parent()
	
func _set_selection():
	await get_tree().create_timer(0.01).timeout
	_select_deselect_highlight()


func _on_previous_button_pressed():
	if index == 0:
		return
	index = index - 1
	parent.current_building_index = index
	parent.update_selected_building()
	var scrollValue = target_scroll - _get_space_between()
	
	await _tween_scroll(scrollValue)
	_select_deselect_highlight()


func _on_next_button_pressed():
	if index == parent.max_building_index - 1:
		return
	index = index + 1
	parent.current_building_index = index
	parent.update_selected_building()
	var scrollValue = target_scroll + _get_space_between()
	
	await _tween_scroll(scrollValue)
	_select_deselect_highlight()


func _get_space_between():
	var distance_size = building_container.get_theme_constant("separation")
	var object_size = building_container.get_children()[1].size.x
	
	return distance_size + object_size


func _tween_scroll(scroll_value):
	target_scroll = scroll_value
	
	var tween = get_tree().create_tween()
	tween.tween_property(scroll_container,"scroll_horizontal", scroll_value, 0.25)
	await tween.finished


func _select_deselect_highlight():
	var selected_node = get_selected_value()
	
	for object in building_container.get_children():
		if object is not TextureRect: continue
		
		if object == selected_node: object.modulate = Color(1,1,1)
		else: object.modulate = Color(0.5,0.5,0.5)
	
func get_selected_value():
	var selected_position = %SelectionMarker.global_position
	
	for object in building_container.get_children():
		if object.get_global_rect().has_point(selected_position):
			return object
