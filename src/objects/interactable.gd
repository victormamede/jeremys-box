class_name Interactable
extends Area2D

signal interaction_started
signal interaction_finished
signal interaction_cancelled
signal interacted(interactor: Interactor)

@export var interaction_time: float = 1.0
@export var disabled: bool = false
@export var max_interaction_distance: float = 8.0

@onready var _timer: Timer = $Timer

var _current_interactor: Interactor = null

func _ready() -> void:
    var e: int

    e = _timer.timeout.connect(_on_timer_timeout)
    assert(e == 0)

func interact(interactor: Interactor) -> bool:
    if disabled:
        return false

    if _current_interactor != null:
        return false

    _current_interactor = interactor
    interaction_started.emit()

    _timer.start(interaction_time)
    return true

func _on_timer_timeout() -> void:
    interacted.emit(_current_interactor)
    interaction_finished.emit()
    _current_interactor = null

func cancel() -> void:
    interaction_cancelled.emit()
    interaction_finished.emit()
    _timer.stop()
    _current_interactor = null
