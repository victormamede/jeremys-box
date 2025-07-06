extends CanvasLayer

@export var inventory: Inventory

@onready var items_container: Control = %ItemsContainer

func _ready() -> void:
    assert(inventory != null)
