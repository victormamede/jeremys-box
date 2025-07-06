extends StaticBody2D

@export var required_items: Array[Item]
@export var has_item_text: Array[String] = ["I can read it!"]
@export var no_item_text: Array[String] = ["Nothing here!"]

@onready var _interactable: Interactable = $Interactable

func _ready() -> void:
    var i: int

    i = _interactable.interacted.connect(_on_interactable_interacted)
    assert(i == 0)

func _on_interactable_interacted(interactor: Interactor) -> void:
    var inventory: Inventory = interactor.player.get_inventory()

    for required_item: Item in required_items:
        if not inventory.has(required_item):
            interactor.player.get_bubble().say(no_item_text)
            return

    interactor.player.get_bubble().say(has_item_text)
