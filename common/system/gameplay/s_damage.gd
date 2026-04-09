class_name DamageSystem
extends System

func query() -> QueryBuilder:
	return q.with_all([C_Health, C_Damage, C_DamageReceiver])

func process(entities: Array[Entity], _components: Array, _delta: float) -> void:
	for entity in entities:
		var health = entity.get_component(C_Health) as C_Health
		var damage = entity.get_component(C_Damage) as C_Damage
		var receiver = entity.get_component(C_DamageReceiver) as C_DamageReceiver

		health.current -= damage.amount
		if receiver.invincible and  health.current <= 0.0:
			health.current = 1.0 

		cmd.remove_component(entity, C_Damage)
		entity.add_component(C_HitFeedback.new())
