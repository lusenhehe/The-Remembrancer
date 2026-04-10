class_name InventoryCommandSystem
extends System

func query():
    return q.with_all([C_Inventory, C_InventoryCommandQueue, C_Input])

func process(entities: Array, _components: Array, _delta: float) -> void:
    for e in entities:
        var queue = e.get_component(C_InventoryCommandQueue)
        var input = e.get_component(C_Input)
        var inventory = e.get_component(C_Inventory)

        if input.ui_inventory_visible and not queue.commands.has(SwitchPanelCommand):
            queue.commands.append(SwitchPanelCommand.new())

        for command in queue.commands: 
            command.execute(inventory)

        queue.commands.clear()
     