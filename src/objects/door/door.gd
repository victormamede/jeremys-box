class_name Door
extends Node2D

signal door_unlocked
signal door_opened

@export var required_item: Item
@export var no_item_text: Array[String] = ["Nothing here!"]

@onready var _interactable: Interactable = $Interactable
@onready var _animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
    var e: int

    e = _interactable.interacted.connect(_on_interactable_interacted)
    assert(e == 0)

func _on_interactable_interacted(interactor: Interactor) -> void:
    var e: int
    var inventory: Inventory = interactor.player.get_inventory()

    if not inventory.has(required_item):
        interactor.player.get_bubble().say(no_item_text)
        assert(e == 0)
        return

    inventory.remove_item(required_item)

    _animation_player.play("opening")
    door_unlocked.emit()
    await _animation_player.animation_finished
    door_opened.emit()
