extends Control

@export var start_scene: PackedScene

func _ready() -> void:
    var e: int

    var start_button: Button = %StartButton
    e = start_button.pressed.connect(_on_start_pressed)
    assert(e == 0)

func _on_start_pressed() -> void:
    var e: int

    e = get_tree().change_scene_to_packed(start_scene)
    assert(e == 0)