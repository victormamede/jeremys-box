extends CanvasLayer

@export var player: Player
@export var inventory: Inventory
@export var item_display_scene: PackedScene

@onready var _items_container: Control = %ItemsContainer

func _ready() -> void:
    assert(inventory != null)
    assert(player != null)
    var e: int

    e = inventory.item_added.connect(_on_item_added)
    assert(e == 0)

    e = inventory.item_removed.connect(_on_item_removed)
    assert(e == 0)


func _on_item_added(item: Item) -> void:
    var item_instance: ItemDisplay = item_display_scene.instantiate()
    item_instance.player = player
    _items_container.add_child(item_instance)
    item_instance.item = item

func _on_item_removed(item: Item) -> void:
    for child: ItemDisplay in _items_container.get_children():
        if child.item == item:
            child.queue_free()
            return