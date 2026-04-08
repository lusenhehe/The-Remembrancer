extends Node

@export var inventory : Inventory

@export var item_id : String

func _ready():
	pass 


func _process(_delta: float):
	if Input.is_action_just_pressed("interact"):
		print_inventory()
	if Input.is_action_just_pressed("add_item_a"):
		inventory.add(item_id, 1)
		print_inventory()
	if Input.is_action_just_pressed("remove_item_a"):
		inventory.remove(item_id, 1)
		print_inventory()


func print_inventory():
	print("Inventory Items:")
	print(inventory.stacks)
	for item in inventory.stacks:
		if item.item_id != "":
			print(item.item_id," x ", item.amount)
		else:
			print("Empty")