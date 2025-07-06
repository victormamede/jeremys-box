class_name NumpadUI
extends CenterContainer

signal code_entered(code: String)

@export var code_length: int = 3

@onready var _numpad: Numpad = %Numpad
@onready var _visor: Label = %Visor

var _current_code: String = ""

func _ready() -> void:
    var e: int

    e = _numpad.button_pressed.connect(_on_numpad_button_pressed)
    assert(e == 0)

    e = _numpad.enter_pressed.connect(_on_numpad_enter_pressed)
    assert(e == 0)

func _on_numpad_button_pressed(number: int) -> void:
    _current_code += str(number)
    _visor.text = _current_code

    if _current_code.length() >= code_length:
        _enter_code()

func _on_numpad_enter_pressed() -> void:
    _enter_code()

func _enter_code() -> void:
    await hide_numpad()
    code_entered.emit(_current_code)
    _current_code = ""
    _visor.text = _current_code

func show_numpad() -> void:
    get_tree().paused = true
    visible = true

    position.y = 200.0
    var tween: Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
    var _tweener: Tweener
    _tweener = tween.tween_property(self, "position", Vector2.ZERO, 0.5)

func hide_numpad() -> void:
    var tween: Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
    var _tweener: Tweener
    _tweener = tween.tween_property(self, "position", Vector2(0.0, 200.0), 0.5)

    await tween.finished

    get_tree().paused = false
    visible = false