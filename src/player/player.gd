class_name Player
extends CharacterBody2D

@export var movement_speed: float = 200.0
@export var acceleration: float = 1.0
@export var stop_threshold: float = 8.0

@onready var _navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _sprite: Sprite2D = $PlayerSprite
@onready var _interactor: Interactor = $Interactor

var _target_interactable: Interactable = null
var _next_position: Vector2 = Vector2.ZERO

func set_interactable_target(interactable: Interactable) -> void:
    _target_interactable = interactable
    _navigation_agent.target_position = interactable.global_position

func set_movement_target(movement_target: Vector2) -> void:
    _navigation_agent.target_position = movement_target

func _interact() -> void:
    assert(_target_interactable != null)
    _interactor.interact(_target_interactable)
    _target_interactable = null

func _ready() -> void:
    _navigation_agent.path_desired_distance = stop_threshold
    _navigation_agent.target_desired_distance = stop_threshold

    _next_position = global_position

func _process(_delta: float) -> void:
    if is_stopped():
        _animation_player.current_animation = "idle"
    else:
        _animation_player.current_animation = "walk"
        _sprite.flip_h = velocity.x > 0

func _physics_process(delta: float) -> void:
    if not _navigation_agent.is_navigation_finished():
        _next_position = _navigation_agent.get_next_path_position()

    if is_stopped():
        if _target_interactable != null and _target_interactable.overlaps_body(self):
            _interact()
    else:
        _interactor.try_cancel_interaction()

    var target_velocity: Vector2 = Vector2.ZERO

    if global_position.distance_squared_to(_next_position) > stop_threshold * stop_threshold:
        target_velocity = global_position.direction_to(_next_position) * movement_speed

    velocity = lerp(velocity, target_velocity, delta * acceleration * movement_speed)

    var _collisions: int = move_and_slide()

func is_stopped() -> bool:
    return velocity.length_squared() < stop_threshold * stop_threshold