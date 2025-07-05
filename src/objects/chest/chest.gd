extends StaticBody2D

func _ready() -> void:
    var interactable: Interactable = $Interactable

    var i: int

    i = interactable.on_interaction_started.connect(print.bind("interaction started"))
    assert(i == 0)

    i = interactable.on_interacted.connect(print.bind("interaction finished"))
    assert(i == 0)

    i = interactable.on_interaction_cancelled.connect(print.bind("interaction cancelled"))
    assert(i == 0)