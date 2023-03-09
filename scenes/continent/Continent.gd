extends MarginContainer


func set_cells(parent_) -> void:
	for champs in parent_.arr.champ:
		for champ in champs:
			var type = champ.word.type
			fill_cell(champ.vec.grid, type)


func fill_cell(vec_: Vector2, type_: String) -> void:
	if type_ != "Empty":
		var tile = get_tile_by_type(type_)
		$Continent.set_cellv(vec_, tile)


func get_tile_by_type(type_: String) -> int:
	var tile = -1
	
	match type_:
		"Black":
			tile = 0
		"Blue":
			tile = 1
		"Green":
			tile = 2
		"Red":
			tile = 3
		"Yellow":
			tile = 4
	
	return tile
