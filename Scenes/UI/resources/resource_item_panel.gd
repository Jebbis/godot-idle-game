extends Panel

@onready var resource_texture: TextureRect = %ResourceTexture as TextureRect
@onready var resource_name: Label = %ResourceName
@onready var resource_amount: Label = %ResourceAmount

var panel_resource: ResourceInventoryItem

func set_resource_data(resource):
	panel_resource = resource
	resource_texture.texture = resource.item.icon
	resource_name.text = resource.item.item_name
	resource_amount.text = str(resource.amount)

func update_resource_data():
	resource_amount.text = str(panel_resource.amount)
