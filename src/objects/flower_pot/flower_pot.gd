extends StaticBody2D

@export var required_items: Array[RequiredItem] = []
@export var has_item_text: Array[String] = ["I can read it!"]

@onready var _interactable: Interactable = $Interactable

func _ready() -> void:
    var i: int

    i = _interactable.interacted.connect(_on_interactable_interacted)
    assert(i == 0)

func _on_interactable_interacted(interactor: Interactor) -> void:
    var inventory: Inventory = interactor.player.get_inventory()

    for required_item: RequiredItem in required_items:
        if not inventory.has(required_item.item):
            interactor.player.get_bubble().say(required_item.text)
            return

    interactor.player.get_bubble().say(has_item_text)
