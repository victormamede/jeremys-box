extends StaticBody2D

@export var drop: PackedScene
@export var animation_duration: float = 1.0

@onready var _interactable: Interactable = $Interactable
@onready var _drop_target: Node2D = $DropTarget

func _ready() -> void:
    var i: int

    i = _interactable.interacted.connect(_on_interactable_interacted)
    assert(i == 0)

func _on_interactable_interacted(_interactor: Interactor) -> void:
    _interactable.disabled = true

    var instance: Node2D = drop.instantiate()
    instance.show_behind_parent = true
    add_child(instance)

    var tween: Tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
    var _tweener: Tweener
    _tweener = tween.tween_property(instance, "position", _drop_target.position, animation_duration)
