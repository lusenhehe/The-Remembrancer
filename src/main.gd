# main.gd
extends Node

@export var world: World
@export var ecs_fps := 60.0
@export var unlimited_fps := false
var _accum := 0.0
var ecs_tick_rate := 1.0 / ecs_fps

func _process(delta):
	if unlimited_fps:
		ECS.process(delta)
		return
	else:
		_accum += delta
		
		if _accum < ecs_tick_rate:
			return
		
		ECS.process(_accum)
		_accum = 0.0

func _ready():
	ecs_tick_rate = 1.0 / ecs_fps
	# 绑定世界
	ECS.world = world 
	# 设置系统和实体
	setup_systems()
	setup_entities()

func setup_systems():
	# 注册系统（输入 -> 移动）并确保 setup 执行
	ECS.world.add_system(InputSystem.new())
	ECS.world.add_system(MovementSystem.new())
	ECS.world.add_system(RenderSystem.new())
	ECS.world.finalize_system_setup()
func setup_entities():
	# 使用 Player.tscn 预设实例化玩家并添加到世界
	var player_scene = preload("res://scene/entities/Player.tscn")
	var entity = player_scene.instantiate()
	ECS.world.add_entity(entity)
  