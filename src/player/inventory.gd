class_name Inventory
extends Node

signal item_added(item: Item)
signal item_removed(item: Item)

var _items: Array[Item] = []

func add_item(item: Item) -> void:
    item_added.emit(item)
    _items.append(item)

func remove_item(item: Item) -> void:
    if not _items.has(item):
        return
    
    item_removed.emit(item)
    var item_index: int = _items.find(item)
    _items.remove_at(item_index)

func has(item: Item) -> bool:
    return _items.has(item)