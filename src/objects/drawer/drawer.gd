extends StaticBody2D

@export var item: Item

@onready var _interactable: Interactable = $Interactable

func _ready() -> void:
    var i: int

    i = _interactable.on_interacted.connect(_on_interactable_interacted)
    assert(i == 0)

func _on_interactable_interacted(interactor: Interactor) -> void:
    interactor.player.get_inventory().add_item(item)
    _interactable.disabled = true
