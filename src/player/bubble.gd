class_name Bubble
extends Control

@onready var _text_label: Label = %Text
@onready var _character_timer: Timer = $CharacterTimer
@onready var _disappear_timer: Timer = $DisappearTimer

var _current_phrase: Array[String] = []

func _ready() -> void:
    var e: int

    e = _character_timer.timeout.connect(_on_character_timer_timeout)
    assert(e == 0)

    e = _disappear_timer.timeout.connect(_on_disappear_timer_timeout)
    assert(e == 0)

    visible = false

func say(phrase: Array[String]) -> void:
    _disappear_timer.stop()
    _character_timer.stop()
    _current_phrase = phrase.duplicate()
    _say_next_line()

func _say_next_line() -> void:
    var current_line: String = _current_phrase.pop_front()

    _text_label.text = current_line
    _text_label.visible_characters = 0
    visible = true
    _disappear_timer.stop()
    _character_timer.start()


func _on_character_timer_timeout() -> void:
    _text_label.visible_characters += 1

    if _text_label.visible_characters >= _text_label.text.length():
        _character_timer.stop()
        _disappear_timer.start()

func _on_disappear_timer_timeout() -> void:
    if _current_phrase.size() > 0:
        _say_next_line()
    else:
        visible = false