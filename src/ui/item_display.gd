class_name ItemDisplay
extends Control

@onready var _texture: TextureRect = %Texture
@onready var _button: BaseButton = $Button

var player: Player

var item: Item = null:
    set(value):
        item = value

        if item != null:
            _texture.texture = item.texture
        else:
            _texture.texture = null

func _ready() -> void:
    var e: int

    e = _button.pressed.connect(_on_button_pressed)
    assert(e == 0)

func _on_button_pressed() -> void:
    if player != null:
        player.get_bubble().say(item.hint_text)