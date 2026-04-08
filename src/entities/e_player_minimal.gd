class_name PlayerMinimal
extends Entity

@export var characterbody: CharacterBody2D
func define_components() -> Array:
    return [
        C_Transform.new(),
        C_Velocity.new(),
        C_Input.new()
    ]

func on_ready() -> void:
    # 设置速度
    var c_vel = get_component(C_Velocity)
    if c_vel:
        c_vel.speed = 200.0

    # 同步组件位置到节点
    var c_transform = get_component(C_Transform)
    if c_transform:
        characterbody.position = c_transform.position
        characterbody.rotation = c_transform.rotation