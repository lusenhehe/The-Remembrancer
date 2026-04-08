# main.gd
extends Node

@export var world: World
@export var ecs_fps := 60.0
var _accum := 0.0
var ecs_tick_rate := 1.0 / ecs_fps

func _process(delta):
	_accum += delta
	
	if _accum < ecs_tick_rate:
		return
	
	ECS.process(_accum)
	_accum = 0.0

func _ready():
	ecs_tick_rate = 1.0 / ecs_fps
	# 绑定世界
	ECS.world = world
	# 创建实体并添加组件
	var entity = Player.new()
	ECS.world.add_entity(entity)
