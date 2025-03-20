extends CharacterBody2D

signal OnStoneUpdate
signal OnBambooUpdate
signal OnPickAxeUpdate

@export var item_dic : Dictionary [String, Vector2i]

@export var move_speed : float = 40.0
@export var jump_velocity : float = 60.0
@export var gravity : float = 70.0
@export var tile_map_layer: TileMapLayer
@export var tile_map_layer_2: TileMapLayer
@onready var sprite: Sprite2D = $Sprite

func mining(tile_map : TileMapLayer):
	var mouse_pos = get_global_mouse_position()
	var tile_pos = tile_map.local_to_map(mouse_pos)
	
	if Inventory.pick_axe > 0:
		tile_map.set_cell(tile_pos, -1)
	
	if tile_map.get_cell_atlas_coords(tile_pos) == item_dic["Bamboo"]:
		tile_map.set_cell(tile_pos, -1)
		OnBambooUpdate.emit()
		Inventory.bamboo += 1
	elif tile_map.get_cell_atlas_coords(tile_pos) == item_dic["Stone"]:
		tile_map.set_cell(tile_pos, -1)
		OnStoneUpdate.emit()
		Inventory.stone += 1

func _physics_process(delta):
	if Input.is_action_just_pressed("mouse_left_click"):
		mining(tile_map_layer)
		mining(tile_map_layer_2)
	
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_velocity
	
	var input = Input.get_axis("left", "right")
	
	velocity.x = input * move_speed
	
	move_and_slide()

func _process(delta):
	if Inventory.pick_axe > 0:
		OnPickAxeUpdate.emit()
	
	if velocity.length() > 0:
		if velocity.x > 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
