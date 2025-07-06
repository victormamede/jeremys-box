extends Node2D

@export var next_scene: PackedScene

func _ready() -> void:
    var e: int
    e = ($AnimationPlayer as AnimationPlayer).animation_finished.connect(_on_animation_finished)
    assert(e == 0)

func _on_animation_finished(_anim_name: StringName) -> void:
    var e: int
    e = get_tree().change_scene_to_packed(next_scene)
    assert(e == 0)