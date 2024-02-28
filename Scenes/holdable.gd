extends Sprite2D

var all_items = {
	"d-sword": preload("res://Resources/curved-sword.tres"),
	"stone-sword": preload("res://Resources/stone-sword.tres"),
	"coin": preload("res://Resources/coin.tres"),
	"blank": null
}
@export var current_resource: Resource
#var item_resource = preload("res://curved-sword.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	change_current_r("d-sword")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if current_resource != null:
		var width: int = current_resource.icon.get_width()
		var scaler: float = 50.0/width
		self.texture = current_resource.icon
		self.scale = Vector2(scaler, scaler)
	else:
		texture = null

func change_current_r(n):
	current_resource = all_items.get(n)
