extends Control
@onready var background_shadow = %BackgroundShadow

var is_bg_shadow_visible: bool = false

func _ready():
	background_shadow.visible = false
	
func set_bg_shadow():
	background_shadow.visible = !is_bg_shadow_visible
	is_bg_shadow_visible = !is_bg_shadow_visible
