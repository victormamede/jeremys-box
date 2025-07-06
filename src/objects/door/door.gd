extends StaticBody2D


@export var next_scene: PackedScene
@export var required_item: Item
@export var no_item_text: Array[String] = ["Nothing here!"]
@export var with_item_text: Array[String] = ["I'm free!"]

@onready var _interactable: Interactable = $Interactable

func _ready() -> void:
    var e: int

    e = _interactable.interacted.connect(_on_interactable_interacted)
    assert(e == 0)

func _on_interactable_interacted(interactor: Interactor) -> void:
    var e: int
    var inventory: Inventory = interactor.player.get_inventory()

    if not inventory.has(required_item):
        interactor.player.get_bubble().say(no_item_text)
        e = get_tree().change_scene_to_packed(next_scene)
        assert(e == 0)
        return

    inventory.remove_item(required_item)

    interactor.player.get_bubble().say(with_item_text)
