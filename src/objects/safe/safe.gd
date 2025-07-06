extends StaticBody2D

@export var item: Item
@export var code: String = "123"

@onready var _interactable: Interactable = $Interactable
@onready var _numpad_ui: NumpadUI = $UI/NumpadUI

var _current_interactor: Interactor = null

func _ready() -> void:
    var i: int

    i = _interactable.interacted.connect(_on_interactable_interacted)
    assert(i == 0)

    i = _numpad_ui.code_entered.connect(_on_numpad_code_entered)
    assert(i == 0)

    _numpad_ui.visible = false

func _on_interactable_interacted(interactor: Interactor) -> void:
    _current_interactor = interactor
    _numpad_ui.show_numpad()

func _on_numpad_code_entered(code_entered: String) -> void:
    if code_entered == code:
        _current_interactor.player.get_bubble().say(["Nice"])
        _current_interactor.player.get_inventory().add_item(item)
        _interactable.disabled = true
    else:
        _current_interactor.player.get_bubble().say(["This is not working"])

    _current_interactor = null