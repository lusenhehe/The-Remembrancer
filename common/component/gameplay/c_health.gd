class_name C_Health
extends Component

@export var current: float = 100.0
@export var maximum: float = 100.0

func _init(_current: float = 100.0, _maximum: float = 100.0) -> void:
    self.current = _current
    self.maximum = _maximum