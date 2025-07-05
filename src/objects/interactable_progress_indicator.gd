extends ProgressBar

@export var interactable: Interactable

var _tween: Tween = null

func _ready() -> void:
    visible = false
    value = 0.0

    var e: int
    e = interactable.on_interaction_started.connect(_on_interaction_started)
    e = interactable.on_interaction_finished.connect(_on_interaction_finished)
    assert(e == 0)

func _on_interaction_started() -> void:
    _tween = create_tween()

    visible = true
    var _tweener: Tweener
    _tweener = _tween.tween_property(self, "value", 1.0, interactable.interaction_time)

func _on_interaction_finished() -> void:
    if _tween != null:
        _tween.stop()

    visible = false
    value = 0.0