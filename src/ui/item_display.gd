class_name ItemDisplay
extends Control

@onready var _texture: TextureRect = %Texture

var item: Item = null:
    set(value):
        item = value

        if item != null:
            _texture.texture = item.texture
        else:
            _texture.texture = null
