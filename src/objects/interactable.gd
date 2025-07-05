class_name Interactable
extends Area2D

signal on_interaction_started
signal on_interaction_finished
signal on_interaction_cancelled
signal on_interacted

@export var interaction_time: float = 1.0;

@onready var _timer: Timer = $Timer

var _is_interacting: bool = false

func _ready() -> void:
    var e: int

    e = _timer.timeout.connect(_on_timer_timeout)
    assert(e == 0)

func interact() -> void:
    if _is_interacting:
        return

    _is_interacting = true
    on_interaction_started.emit()

    _timer.start(interaction_time)

func _on_timer_timeout() -> void:
    on_interacted.emit()
    on_interaction_finished.emit()
    _is_interacting = false

func cancel() -> void:
    on_interaction_cancelled.emit()
    on_interaction_finished.emit()
    _timer.stop()
    _is_interacting = false
