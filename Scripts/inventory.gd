extends Node

signal remove_slot(name : String)

var stone : int = 0
var bamboo : int = 0
var pick_axe : int = 0

var invetory_selection : int
var selected_slot_name : String

var is_inventory_full : bool

func remove_bamboo():
	bamboo -= 1
	remove_slot.emit("Bamboo")
	
func remove_stone():
	stone -= 1
	remove_slot.emit("Stone")

func remove_pickaxe():
	pick_axe -= 1
	remove_slot.emit("Pickaxe")

func _process(delta):
	if stone + bamboo + pick_axe >= 7:
		is_inventory_full = true
		print("Inventory is full")
	else:
		is_inventory_full = false
