extends Button

var slot_num: int
@export var item_name: String
@export var item_count: int

func _ready():
	item_count =  0
	item_name = ""
	
func get_item():
	var item_node = $frame/item  
	var resource = item_node.current_resource 
	
	if resource:
		return resource 
	else:
		return "No resource"

func remove_from_slot():
	$frame/item.change_current_r("blank")
	item_name = ""
	

func add_to_slot(nam, count):
	$frame/item.change_current_r(nam)
	item_count += count
	item_name = nam
	update_count()
	
func add_count():
	item_count += 1
	update_count()

func sub_count():
	item_count -= 1
	update_count()

func set_slot_num(n):
	slot_num = n
	
func update_count():
	$frame/item_num.text = str(item_count)
	$frame/item_num.visible = true
	if item_count <= 0:
		$frame/item_num.visible = false


func _on_button_down():

	if item_name != "":
		if !get_parent().get_parent().item_held:
			get_parent().get_parent().floatify(item_name, item_count)
			#Remove original slot here
			remove_from_slot()
			item_count = 0
			update_count()
			
		else:
			get_parent().get_parent().swap_item(item_name, item_count)
	else:
		if get_parent().get_parent().item_held:
			get_parent().get_parent().insert_item(slot_num)
			
	get_parent().get_parent().change_slot(slot_num)


func _process(_delta):
	if get_parent().get_parent().active_slot == slot_num:
		$frame.texture = load("res://Art/slot1_selected.png")
	else:
		$frame.texture = load("res://Art/Kasaya's Frames/Inventory & chests/1/slot1.png")
