class_name Tutorial
extends MarginContainer

@export var show_interval: float = 0.05

@onready var _hide_timer: Timer = $HideTimer
@onready var _label: Label = %Label

var _counter: float = 0.0
var _running: bool = false

func _ready() -> void:
    var e: int

    e = _hide_timer.timeout.connect(hide_tutorial)
    assert(e == 0)
    
    hide()

func show_tutorial() -> void:
    _label.visible_characters = 0
    position.y = 100.0

    var tween: Tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT).set_parallel()
    var _tweener: Tweener

    show()
    _tweener = tween.tween_property(self, "position", Vector2.ZERO, 1.0)
    await tween.finished
    _running = true

func _process(delta: float) -> void:
    if !_running:
        return

    _counter += delta
    if _counter > show_interval:
        _next_character()
        _counter -= show_interval

func hide_tutorial() -> void:
    var tween: Tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN_OUT).set_parallel()
    var _tweener: Tweener

    _tweener = tween.tween_property(self, "position", Vector2(0.0, 200.0), 1.0)
    await tween.finished
    hide()

func _next_character() -> void:
    _label.visible_characters += 1
    if _label.visible_characters >= _label.text.length():
        _running = false
        _hide_timer.start()