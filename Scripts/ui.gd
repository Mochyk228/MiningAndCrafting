extends CanvasLayer

@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var player: CharacterBody2D = get_parent()
@onready var children = h_box_container.get_children()
@onready var empty_slot = children[0].texture

const SLOT : Texture2D = preload("res://Art/slot.png")
const BAMBOO_SLOT : Texture2D = preload("res://Art/bamboo_slot.png")
const STONE_SLOT : Texture2D = preload("res://Art/stone_slot.png")
const PICK_AXE = preload("res://Art/pick_axe.png")

func _ready():
	player.OnStoneUpdate.connect(add_stone)
	player.OnBambooUpdate.connect(add_bamboo)
	player.OnPickAxeUpdate.connect(add_pick_axe)
	
	Inventory.remove_slot.connect(update_removment)

func add_stone():
	add_slot(STONE_SLOT)

func add_bamboo():
	add_slot(BAMBOO_SLOT)

func add_pick_axe():
	add_slot(PICK_AXE)

func add_slot(slot_texture : Texture2D):
	for child : TextureRect in children:
		if child.texture == empty_slot:
			child.texture = slot_texture
			return

func remove_slot(slot_texture : Texture2D):
	for child : TextureRect in children:
		if child.texture == slot_texture:
			child.texture = empty_slot
			return

func update_removment(name : String):
	if name == "Bamboo":
		remove_slot(BAMBOO_SLOT)
	elif name == "Stone":
		remove_slot(STONE_SLOT)
	elif name == "Pickaxe":
		remove_slot(PICK_AXE)

func _process(_delta):
	for i in children:
		i.modulate = Color.WHITE
	children[Inventory.invetory_selection].modulate = Color.NAVAJO_WHITE
	
	if children[Inventory.invetory_selection].texture.resource_path.get_file() == "slot.png":
		Inventory.selected_slot_name = "Slot"
	elif children[Inventory.invetory_selection].texture.resource_path.get_file() == "bamboo_slot.png":
		Inventory.selected_slot_name = "Bamboo"
	elif children[Inventory.invetory_selection].texture.resource_path.get_file() == "stone_slot.png":
		Inventory.selected_slot_name = "Stone"
	elif children[Inventory.invetory_selection].texture.resource_path.get_file() == "pick_axe.png":
		Inventory.selected_slot_name = "Pickaxe"
	
	if Input.is_action_just_pressed("remove"):
		children[Inventory.invetory_selection].texture = empty_slot
