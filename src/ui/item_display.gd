extends TextureRect

@export var item: Item:
    set(value):
        item = value
        _recalculate()
    
func _recalculate() -> void:
    if item != null:
        texture = item.texture
    else:
        texture = null