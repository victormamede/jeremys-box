@tool

class_name Numpad
extends GridContainer

signal button_pressed(number: int)
signal enter_pressed()

func _ready() -> void:
    var e: int

    for i: int in range(1, 10):
        var button: Button = Button.new()
        button.text = str(i)
        add_child(button)

        e = button.pressed.connect(button_pressed.emit.bind(i))
        assert(e == 0)

    add_child(Control.new())
    var button_zero: Button = Button.new()
    button_zero.text = str(0)
    add_child(button_zero)

    e = button_zero.pressed.connect(button_pressed.emit.bind(0))
    assert(e == 0)

    var button_enter: Button = Button.new()
    button_enter.text = "E"
    add_child(button_enter)

    e = button_enter.pressed.connect(enter_pressed.emit)
    assert(e == 0)
