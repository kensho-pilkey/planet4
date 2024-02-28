extends Control

@export var item_held: bool = false
var item_slot_scene = preload("res://Scenes/item_slot.tscn")
@export var active_slot: int
var slots = []
var floater

func _ready():
	toggle_inventory()
	var slot
	active_slot = 27
	for i in 27:
		slot = item_slot_scene.instantiate()
		slot.set_slot_num(i)
		slots.append(slot)
		$inventory.add_child(slot)
#Puts item slots in hotbar 1 - 9
	for i in 9:
		slot = item_slot_scene.instantiate()
		slot.set_slot_num(27 + i)
		slots.append(slot)
		$hotbar.add_child(slot)

func add_item(item, count):
	if !has_item(item):
		var added = false
		for i in 9:
			if slots[27+i].item_name == "":
				slots[27+i].add_to_slot(item, count)
				#slots[27+i].add_count()
				added = true
				break
		if !added:
			for j in 27:
				if slots[j].item_name == "":
					slots[j].add_to_slot(item, count)
					slots[j].add_count()
					break

func has_item(item):
	for i in 36:
		if slots[35-i].item_name == item:
			slots[35-i].add_count()
			return true 
	return false


func remove_item():
	if slots[active_slot].item_count == 1:
		slots[active_slot].remove_from_slot()
		slots[active_slot].sub_count()
	if slots[active_slot].item_count > 1:
		slots[active_slot].sub_count()

func get_item_name(i: int):
	return slots[i].item_name

func toggle_inventory():
	$inventory.visible = !$inventory.visible
	$TextureRect.visible = !$TextureRect.visible

func change_slot(num):
	active_slot = num

func swap_item(item_name, count):
	if item_name == floater.get_img_name():
		add_item(floater.get_img_name(), floater.get_item_count())
		floater.queue_free()
		item_held = false
	else:
		add_item(floater.get_img_name(), floater.get_item_count())
		floater.queue_free()
		floatify(item_name, count)
		

func insert_item(slot_num):
	if item_held:
		slots[slot_num].add_to_slot(floater.get_img_name(), floater.get_item_count())
		floater.queue_free()
		item_held = false


func floatify(item_num, count):
	floater = load("res://Scenes/floating_item.tscn").instantiate()
	floater.toggle_follow()
	floater.set_image(item_num, count)
	add_child(floater)
	item_held = true
	
func _process(_delta):
	pass
