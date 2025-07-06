extends StaticBody2D

@export var text: Array[String] = ["Nothing here!"]

@onready var _interactable: Interactable = $Interactable

func _ready() -> void:
    var i: int

    i = _interactable.interacted.connect(_on_interactable_interacted)
    assert(i == 0)

func _on_interactable_interacted(interactor: Interactor) -> void:
    interactor.player.get_bubble().say(text)
