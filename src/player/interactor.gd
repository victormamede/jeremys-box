class_name Interactor
extends Node2D

var _current_interacting: Interactable = null

func interact(interactable: Interactable) -> void:
    _current_interacting = interactable
    _current_interacting.interact()

    await _current_interacting.on_interaction_finished
    _current_interacting = null

func try_cancel_interaction() -> void:
    if _current_interacting == null:
        return
    
    _current_interacting.cancel()