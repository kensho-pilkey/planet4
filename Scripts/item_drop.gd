extends Area2D

var all_items = {
	"d-sword": preload("res://Resources/curved-sword.tres"),
	"stone-sword": preload("res://Resources/stone-sword.tres"),
	"coin": preload("res://Resources/coin.tres")
}
var item_count: int  = 0

var follow_cursor = false
var img: Resource
var img_name: String
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("item")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if follow_cursor:
		self.global_position = get_global_mouse_position()
	
func get_img_name():
	return img_name
	
func get_item_count():
	return item_count
	
func toggle_follow():
	follow_cursor = !follow_cursor
	
func set_image(n: String, count: int):
	item_count = count
	img_name = n
	img = all_items.get(n)
	$Sprite2D.texture = img.icon
	var scaler: float = 10.0/ img.icon.get_width()
	if !follow_cursor:
		$Sprite2D.scale = Vector2(scaler, scaler)
	else:
		$Sprite2D.scale = Vector2(3 * scaler, 3 * scaler)

func _on_body_entered(body):
	if body.has_method("player"):
		queue_free()
