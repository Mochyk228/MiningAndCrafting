extends Area2D

var is_mouse_hovering : bool
var is_mouse_outside : bool
var is_slot1_ready : bool
var is_slot2_ready : bool

@onready var canvas_layer: CanvasLayer = $CanvasLayer
const BAMBOO_SLOT = preload("res://Art/bamboo_slot.png")
const STONE_SLOT = preload("res://Art/stone_slot.png")
const SLOT = preload("res://Art/slot.png")
const PICK_AXE = preload("res://Art/pick_axe.png")

func _on_mouse_entered() -> void:
	is_mouse_hovering = true

func _on_mouse_exited() -> void:
	is_mouse_hovering = false

func _on_funarance_menu_mouse_exited() -> void:
	is_mouse_outside = false

func _on_funarance_menu_mouse_entered() -> void:
	is_mouse_outside = true

func _process(delta):
	if is_mouse_hovering and Input.is_action_just_pressed("mouse_left_click"):
		canvas_layer.visible = true
	
	if is_mouse_outside and Input.is_action_just_pressed("mouse_left_click"):
		canvas_layer.visible = false
	
	if Inventory.stone >= 1:
		$CanvasLayer/Control/FunaranceMenu/Item1.texture = STONE_SLOT
		is_slot1_ready = true
	else:
		$CanvasLayer/Control/FunaranceMenu/Item1.texture = SLOT
		is_slot1_ready = false
	if Inventory.bamboo >= 1:
		$CanvasLayer/Control/FunaranceMenu/Item2.texture = BAMBOO_SLOT
		is_slot2_ready = true
	else:
		$CanvasLayer/Control/FunaranceMenu/Item2.texture = SLOT
		is_slot2_ready = false
		
	if canvas_layer.visible == true and is_slot1_ready and is_slot2_ready:
		Inventory.stone -= 1
		Inventory.bamboo -= 1
		Inventory.pick_axe += 1
		$CanvasLayer/Control/FunaranceMenu/FinishItem.texture = PICK_AXE
# if inventory stone is more than 1 change texture and remove stone from inventory
# When all is ready furge a pick axe and add it to inventory 
# activate to be able to brake all the blocks
