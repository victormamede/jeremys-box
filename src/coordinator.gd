class_name Coordinator
extends Node2D

@export var enabled: bool = true
@export var player: Player
@export_flags_2d_physics var interactable_mask: int = 1


func _unhandled_input(event: InputEvent) -> void:
    if not enabled:
        return

    if event is InputEventMouse and event.is_action_pressed("click"):
        var mouse_event: InputEventMouse = event
        var mouse_position: Vector2 = mouse_event.global_position * get_canvas_transform()

        var space: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
        var params: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
        params.collide_with_areas = true
        params.collide_with_bodies = false
        params.collision_mask = interactable_mask
        params.position = mouse_position

        var results: Array[Dictionary] = space.intersect_point(params)

        for result: Dictionary in results:
            var collider: Node = result["collider"]
            if collider is Interactable:
                var interactable: Interactable = collider
                player.set_interactable_target(interactable)
                return

        player.set_movement_target(mouse_position)