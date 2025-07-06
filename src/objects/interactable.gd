class_name Interactable
extends Area2D

signal on_interaction_started
signal on_interaction_finished
signal on_interaction_cancelled
signal on_interacted(interactor: Interactor)

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
    on_interaction_started.emit()

    _timer.start(interaction_time)
    return true

func _on_timer_timeout() -> void:
    on_interacted.emit(_current_interactor)
    on_interaction_finished.emit()
    _current_interactor = null

func cancel() -> void:
    on_interaction_cancelled.emit()
    on_interaction_finished.emit()
    _timer.stop()
    _current_interactor = null
