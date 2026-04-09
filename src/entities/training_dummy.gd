class_name TrainingDummy
extends Entity

@onready var sprite: Sprite2D = $Sprite2D

func define_components() -> Array:
	var health = C_Health.new()
	health.current = 100.0
	health.maximum = 100.0

	var receiver = C_DamageReceiver.new()
	receiver.invincible = true

	var view = C_View.new()
	return [health, receiver, view]

func on_ready() -> void:
	var view = get_component(C_View) as C_View
	if view:
		view.node = self
