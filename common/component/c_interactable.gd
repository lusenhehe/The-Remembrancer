class_name C_Interactable
extends Component

var interact_area: Area2D = null
var interact_type: String = "" # "chest", "npc", "loot"
var target_node:   Node = null # Optional for UI/animation 