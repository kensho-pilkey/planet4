extends TileMap

#Each tile is 16x16 pixels
var width : int = 16
var height : int =  16

# Genertes 16 x 16 tilemap based on the noise parameter. 
func generate(noise):
	var noise_val
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			noise_val = noise.get_noise_2d(x,y)
			
			if noise_val > 0:
				set_cell(0, Vector2(x,y), 0, Vector2(7,1))
			else:
				set_cell(0, Vector2(x,y), 0, Vector2(12,1))
