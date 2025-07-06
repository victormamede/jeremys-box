extends TextureRect

func _ready() -> void:
    var tween: Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
    var _tweener: Tweener
    var final_intensity: float = material["shader_parameter/vignette_intensity"]
    var final_opacity: float = material["shader_parameter/vignette_opacity"]
    material["shader_parameter/vignette_intensity"] = 20.0
    material["shader_parameter/vignette_opacity"] = 1.0
    tween = tween.set_parallel()
    _tweener = tween.tween_property(material, "shader_parameter/vignette_intensity", final_intensity, 1.0)
    _tweener = tween.tween_property(material, "shader_parameter/vignette_opacity", final_opacity, 1.0)
