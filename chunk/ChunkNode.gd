extends Node2D


var chunk_coords = Vector2()
var chunk_data = []


func start(_chunk_coords):
	chunk_coords = _chunk_coords
	$Coords.text = str(chunk_coords)
	
	#Checks if chunk is saved in WorldSave singleton 
	if WorldSave.loaded_coords.find(_chunk_coords) == -1:
		
		var noise = FastNoiseLite.new()
		noise.seed = randi()
		
		$chunk_tiles.generate(noise)
		WorldSave.add_chunk(chunk_coords)
		chunk_data.append(noise)
	else:
		chunk_data = WorldSave.retrive_data(chunk_coords)
		$chunk_tiles.generate(chunk_data[0])

func save():
	WorldSave.save_chunk(chunk_coords, chunk_data)
	queue_free()
