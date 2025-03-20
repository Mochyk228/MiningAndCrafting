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
