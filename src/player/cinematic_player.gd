@tool
extends Node2D

enum PlayerAnimation {IDLE, WALKING, SCARED, LYING}

@export var animation: PlayerAnimation = PlayerAnimation.IDLE:
    set(value):
        animation = value

        if not is_node_ready():
            return

        match (animation):
            PlayerAnimation.IDLE:
                _animation_player.current_animation = "idle"
            PlayerAnimation.WALKING:
                _animation_player.current_animation = "walk"
            PlayerAnimation.SCARED:
                _animation_player.current_animation = "scared"
            PlayerAnimation.LYING:
                _animation_player.current_animation = "lying"


@onready var _bubble: Bubble = $Bubble
@onready var _animation_player: AnimationPlayer = $AnimationPlayer

func get_bubble() -> Bubble:
    return _bubble

func say(text: String, speed: float = 0.0) -> void:
    if speed > 0.0:
        _bubble.set_character_speed(speed)

    _bubble.say([text])