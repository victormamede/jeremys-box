extends Node2D

@export var item: Item

@onready var _sprite: Sprite2D = $Sprite2D
@onready var _interactable: Interactable = $Interactable

func _ready() -> void:
    _sprite.texture = item.texture

    var i: int

    i = _interactable.interacted.connect(_on_interactable_interacted)
    assert(i == 0)

func _on_interactable_interacted(interactor: Interactor) -> void:
    var inventory: Inventory = interactor.player.get_inventory()
    inventory.add_item(item)
    _interactable.disabled = true
    queue_free()
