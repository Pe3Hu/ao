extends Node


class Champ:
	var word = {}
	var vec = {}
	var dict = {}
	var arr = {}


	func _init(input_) -> void:
		arr.territoire = []
		word.type = "Empty"
		vec.grid = input_.grid


	func is_empty() -> bool:
		return word.type == "Empty" && arr.territoire.size() == 0


	func is_dead() -> bool:
		return word.type == "Dead"


class Territoire:
	var word = {}
	var arr = {}
	var obj = {}


	func _init(input_) -> void:
		word.color = input_.color
		arr.champ = input_.champs
		obj.continent = input_.continent
		
		for champ in arr.champ:
			champ.arr.territoire.append(self)
			obj.continent.scene.self.fill_cell(champ.vec.grid, word.color)


class Continent:
	var num = {}
	var arr = {}
	var dict = {}
	var obj = {}
	var scene = {}


	func _init() -> void:
		init_num()
		init_scene()
		init_arr()
		scene.self.set_cells(self)


	func init_num() -> void:
		var n = 100
		num.rows = n
		num.cols = n


	func init_scene() -> void:
		scene.self = Global.scene.continent.instance()
		Global.node.game.add_child(scene.self)


	func init_arr() -> void:
		init_champs()
		init_territoires()


	func init_champs() -> void:
		arr.champ = []
		
		for _i in num.rows:
			arr.champ.append([])
			
			for _j in num.cols:
				var input = {}
				input.grid = Vector2(_j,_i)
				var champ = Classes_1.Champ.new(input)
				arr.champ[_i].append(champ)
		
		set_champ_neighbors()


	func set_champ_neighbors() -> void:
		for champs in arr.champ:
			for champ in champs:
				champ.dict.neighbor = {}
				
				for vector in Global.dict.neighbor.linear:
					var neighbor_grid = champ.vec.grid + vector
					
					if check_border(neighbor_grid):
						var neighbor = arr.champ[neighbor_grid.y][neighbor_grid.x]
						champ.dict.neighbor[vector] = neighbor


	func init_territoires() -> void:
		dict.territoire = {}
		var start_grid = arr.champ[0][0].vec.grid
		var kinds = get_territoire_kinds(start_grid)
		var kind = Global.get_random_element(kinds)
		var territoire_frontier = []
		add_territoire(start_grid, kind, territoire_frontier)
		var stop = find_place_for_new_territoire(territoire_frontier)
		
		for _i in 100:
			find_place_for_new_territoire(territoire_frontier)
		
		#while stop:
		#	stop = find_place_for_new_territoire(territoire_frontier)
			
		
		for champ in territoire_frontier:
			scene.self.fill_cell(champ.vec.grid, "Black")


	func find_place_for_new_territoire(territoire_frontier_: Array) -> bool:
		var datas = [] 
		
		for champ in territoire_frontier_:
			var kinds = get_territoire_kinds(champ.vec.grid)
			
			if kinds.size() == 0:
				#champ.word.type = "Dead"
				territoire_frontier_.erase(champ)
			else:
				for kind in kinds:
					var count = count_territoire_neighbors(champ.vec.grid, kind)
					
					if count > 1:
						var data = {}
						data.kind = kind
						data.champ = champ
						data.value = count
						datas.append(data)
		
		if datas.size() == 0:
			return false
		
		datas.sort_custom(Classes_0.Sorter, "sort_descending")
		var options = []
		
		for data in datas:
			#if data.value == datas.front().value:
			for _i in pow(data.value, 3):
				options.append(data)
		
		var data = Global.get_random_element(options)
		add_territoire(data.champ.vec.grid, data.kind, territoire_frontier_)
		return true


	func get_territoire_kinds(start_grid_: Vector2) -> Array:
		var kinds = []
		
		for kind in Global.dict.territoire.kind.keys():
			var success = true
			
			for shift in Global.dict.territoire.kind[kind]:
				if success:
					var grid = start_grid_+shift
					success = success && check_border(grid)
					
					if success:
						success = success && arr.champ[grid.y][grid.x].is_empty()
			
			if success:
				kinds.append(kind)
		
		return kinds


	func count_territoire_neighbors(start_grid_, kind_) -> int:
		var neighbors = []
		
		for shift in Global.dict.territoire.kind[kind_]:
			var grid = start_grid_+shift
			var champ = arr.champ[grid.y][grid.x]
			
			for vector in champ.dict.neighbor:
				var neighbor = champ.dict.neighbor[vector]
			
				if !neighbor.is_empty() && !neighbors.has(neighbor):
					neighbors.append(neighbor)
		
		return neighbors.size()


	func add_territoire(start_grid_: Vector2, kind_: String, territoire_frontier_: Array) -> void:
		var input = {}
		input.color = Global.get_random_element(Global.arr.color)
		input.champs = []
		input.continent = self
		
		for shift in Global.dict.territoire.kind[kind_]:
			var grid = start_grid_+shift
			input.champs.append(arr.champ[grid.y][grid.x])
		
		var territoire = Classes_1.Territoire.new(input)
		
		if !dict.territoire.keys().has(input.champs.size()):
			dict.territoire[input.champs.size()] = []
		
		dict.territoire[input.champs.size()].append(territoire)
		
		for champ in territoire.arr.champ:
			for vector in champ.dict.neighbor:
				var neighbor = champ.dict.neighbor[vector]
				
				if !territoire.arr.champ.has(neighbor) && !territoire_frontier_.has(neighbor):
					territoire_frontier_.append(neighbor)
		
		for _i in range(territoire_frontier_.size()-1,-1,-1):
			if territoire_frontier_[_i].arr.territoire.size() > 0:
				territoire_frontier_.remove(_i)


	func check_border(grid_) -> bool:
		return grid_.x >= 0 && grid_.x < num.cols && grid_.y >= 0 && grid_.y < num.rows
