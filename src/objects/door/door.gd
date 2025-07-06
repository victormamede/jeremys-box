extends StaticBody2D

@export var required_item: Item
@export var no_item_text: Array[String] = ["Nothing here!"]
@export var with_item_text: Array[String] = ["I'm free!"]

@onready var _interactable: Interactable = $Interactable

func _ready() -> void:
    var i: int

    i = _interactable.interacted.connect(_on_interactable_interacted)
    assert(i == 0)

func _on_interactable_interacted(interactor: Interactor) -> void:
    var inventory: Inventory = interactor.player.get_inventory()

    if not inventory.has(required_item):
        interactor.player.get_bubble().say(no_item_text)
        return

    inventory.remove_item(required_item)

    interactor.player.get_bubble().say(with_item_text)
