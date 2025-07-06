extends Node2D

@export var door: Door
@export var end_position: Node2D
@export var next_scene: PackedScene
@export var cinematic_player: CinematicPlayer
@export var player: Node2D

func _ready() -> void:
    var e: int
    e = door.door_unlocked.connect(_on_door_unlocked)
    assert(e == 0)

    e = door.door_opened.connect(_on_door_opened)
    assert(e == 0)

func _on_door_unlocked() -> void:
    cinematic_player.global_position = player.global_position
    cinematic_player.animation = CinematicPlayer.PlayerAnimation.SCARED
    cinematic_player.show()
    player.hide()


func _on_door_opened() -> void:
    var tween: Tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT).set_parallel()
    var _tweener: Tweener
    _tweener = tween.tween_property(cinematic_player, "global_position", end_position.global_position, 3.0)
    _tweener = tween.tween_property(cinematic_player, "rotation", PI * 4, 3.0)
    _tweener = tween.tween_property(cinematic_player, "scale", Vector2.ZERO, 3.0)

    await tween.finished

    var e: int
    e = get_tree().change_scene_to_packed(next_scene)
    assert(e == 0)