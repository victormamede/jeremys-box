class_name Interactor
extends Node2D

@export var player: Player

var _current_interacting: Interactable = null

func interact(interactable: Interactable) -> void:
    assert(player != null)
    _current_interacting = interactable
    var success: bool = _current_interacting.interact(self)

    if success:
        await _current_interacting.on_interaction_finished
        _current_interacting = null
    else:
        print("Failed to interact")

func try_cancel_interaction() -> void:
    if _current_interacting == null:
        return
    
    _current_interacting.cancel()