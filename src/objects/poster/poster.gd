extends Node2D

@export var drop: PackedScene
@export var required_item: Item
@export var no_item_text: Array[String] = ["Nothing here!"]

@onready var _interactable: Interactable = $Interactable
@onready var _animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
    var i: int

    i = _interactable.on_interacted.connect(_on_interactable_interacted)
    assert(i == 0)

func _on_interactable_interacted(interactor: Interactor) -> void:
    var inventory: Inventory = interactor.player.get_inventory()

    if not inventory.has(required_item):
        interactor.player.get_bubble().say(no_item_text)
        return

    inventory.remove_item(required_item)
    _animation_player.play("burning")
    _interactable.disabled = true

    await _animation_player.animation_finished

    var instance: Node2D = drop.instantiate()
    instance.position = position
    get_parent().add_child(instance)
    queue_free()
