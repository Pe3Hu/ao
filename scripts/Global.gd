extends Node


var rng = RandomNumberGenerator.new()
var num = {}
var dict = {}
var arr = {}
var obj = {}
var node = {}
var flag = {}
var vec = {}
var scene = {}

var mouse_pressed = false


func init_num() -> void:
	init_primary_key()
	num.map = {}


func init_primary_key() -> void:
	num.primary_key = {}
	num.primary_key.territoire = 0


func init_dict() -> void:
	init_window_size()
	
	dict.neighbor = {}
	dict.neighbor.linear = [
		Vector2( 0,-1),
		Vector2( 1, 0),
		Vector2( 0, 1),
		Vector2(-1, 0)
	]
	dict.neighbor.diagonal = [
		Vector2( 1,-1),
		Vector2( 1, 1),
		Vector2(-1, 1),
		Vector2(-1,-1)
	]
	
	set_territoire_kinds()
	

func init_window_size() -> void:
	dict.window_size = {}
	dict.window_size.width = ProjectSettings.get_setting("display/window/size/width")
	dict.window_size.height = ProjectSettings.get_setting("display/window/size/height")
	dict.window_size.center = Vector2(dict.window_size.width/2, dict.window_size.height/2)


func set_territoire_kinds() -> void:
	dict.territoire = {}
	dict.territoire.kind = {}
	dict.territoire.kind["0"] = [
		Vector2(0, 0), Vector2(1, 0), Vector2(2, 0), Vector2(3, 0), Vector2(4, 0), Vector2(5, 0), Vector2(6, 0),
		Vector2(0, 1), Vector2(1, 1), Vector2(2, 1), Vector2(3, 1), Vector2(4, 1), Vector2(5, 1), Vector2(6, 1),
		Vector2(2, 2), Vector2(3, 2), Vector2(4, 2), Vector2(5, 2), Vector2(4, 3), Vector2(5, 3)
	]
	dict.territoire.kind["1"] = [
		Vector2(0, 0), Vector2(0, 1), Vector2(0, 2), Vector2(0, 3), Vector2(0, 4), Vector2(0, 5), Vector2(0, 6),
		Vector2(1, 0), Vector2(1, 1), Vector2(1, 2), Vector2(1, 3), Vector2(1, 4), Vector2(1, 5), Vector2(1, 6),
		Vector2(-1, 2), Vector2(-1, 3), Vector2(-1, 4), Vector2(-1, 5), Vector2(-2, 4), Vector2(-2, 5)
	]
	dict.territoire.kind["2"] = [
		Vector2(0, 2), Vector2(1, 2), Vector2(2, 2), Vector2(3, 2), Vector2(4, 2), Vector2(5, 2), Vector2(-1, 2),
		Vector2(0, 3), Vector2(1, 3), Vector2(2, 3), Vector2(3, 3), Vector2(4, 3), Vector2(5, 3), Vector2(-1, 3),
		Vector2(0, 0), Vector2(1, 0), Vector2(0, 1), Vector2(1, 1), Vector2(2, 1), Vector2(3, 1)
	]
	dict.territoire.kind["3"] = [
		Vector2(0, 0), Vector2(0, 1), Vector2(0, 2), Vector2(0, 3), Vector2(0, 4), Vector2(0, 5), Vector2(0, 6),
		Vector2(1, 0), Vector2(1, 1), Vector2(1, 2), Vector2(1, 3), Vector2(1, 4), Vector2(1, 5), Vector2(1, 6),
		Vector2(2, 1), Vector2(2, 2), Vector2(2, 3), Vector2(2, 4), Vector2(3, 1), Vector2(3, 2)
	]
	dict.territoire.kind["4"] = [
		Vector2(0, 0), Vector2(1, 0), Vector2(2, 0), Vector2(3, 0), Vector2(4, 0), Vector2(5, 0), Vector2(6, 0),
		Vector2(0, 1), Vector2(1, 1), Vector2(2, 1), Vector2(3, 1), Vector2(4, 1), Vector2(5, 1), Vector2(6, 1),
		Vector2(1, 2), Vector2(2, 2), Vector2(3, 2), Vector2(4, 2), Vector2(1, 3), Vector2(2, 3)
	]
	dict.territoire.kind["5"] = [
		Vector2(0, 0), Vector2(0, 1), Vector2(0, 2), Vector2(0, 3), Vector2(0, 4), Vector2(0, 5), Vector2(0, 6),
		Vector2(1, 0), Vector2(1, 1), Vector2(1, 2), Vector2(1, 3), Vector2(1, 4), Vector2(1, 5), Vector2(1, 6),
		Vector2(-1, 1), Vector2(-1, 2), Vector2(-1, 3), Vector2(-1, 4), Vector2(-2, 1), Vector2(-2, 2)
	]
	dict.territoire.kind["6"] = [
		Vector2(0, 2), Vector2(1, 2), Vector2(2, 2), Vector2(-1, 2), Vector2(-2, 2), Vector2(-3, 2), Vector2(-4, 2),
		Vector2(0, 3), Vector2(1, 3), Vector2(2, 3), Vector2(-1, 3), Vector2(-2, 3), Vector2(-3, 3), Vector2(-4, 3),
		Vector2(0, 0), Vector2(1, 0), Vector2(0, 1), Vector2(1, 1), Vector2(-1, 1), Vector2(-2, 1)
	]
	dict.territoire.kind["7"] = [
		Vector2(0, 0), Vector2(0, 1), Vector2(0, 2), Vector2(0, 3), Vector2(0, 4), Vector2(0, 5), Vector2(0, 6),
		Vector2(1, 0), Vector2(1, 1), Vector2(1, 2), Vector2(1, 3), Vector2(1, 4), Vector2(1, 5), Vector2(1, 6),
		Vector2(2, 2), Vector2(2, 3), Vector2(2, 4), Vector2(2, 5), Vector2(3, 4), Vector2(3, 5)
	]


func init_arr() -> void:
	arr.sequence = {} 
	arr.sequence["A000040"] = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
	arr.sequence["A000045"] = [89, 55, 34, 21, 13, 8, 5, 3, 2, 1, 1]
	arr.sequence["A000124"] = [7, 11, 16] #, 22, 29, 37, 46, 56, 67, 79, 92, 106, 121, 137, 154, 172, 191, 211]
	arr.sequence["A001358"] = [4, 6, 9, 10, 14, 15, 21, 22, 25, 26]
	arr.sequence["B000000"] = [2, 3, 5, 8, 10, 13, 17, 20, 24, 29, 33, 38]
	arr.color = ["Red","Green","Blue","Yellow"]


func init_node() -> void:
	node.game = get_node("/root/Game") 


func init_flag() -> void:
	flag.click = false
	flag.stop = false


func init_vec() -> void:
	vec.size = {}
	vec.size.champ = Vector2(4, 4)
	
	vec.scale = {}
	vec.scale.continent = Vector2(0.25, 0.25)


func init_scene() -> void:
	scene.continent = load("res://scenes/continent/Continent.tscn")


func _ready() -> void:
	init_dict()
	init_num()
	init_arr()
	init_node()
	init_flag()
	init_vec()
	init_scene()


func get_random_element(arr_: Array):
	if arr_.size() == 0:
		print("!bug! empty array in get_random_element func")
		return null
	
	rng.randomize()
	var index_r = rng.randi_range(0, arr_.size()-1)
	return arr_[index_r]


func save_json(data_,file_path_,file_name_) -> void:
	var file = File.new()
	file.open(file_path_+file_name_+".json", File.WRITE)
	file.store_line(to_json(data_))
	file.close()


func load_json(file_path_,file_name_) -> Dictionary:
	var file = File.new()
	
	if not file.file_exists(file_path_+file_name_+".json"):
			 #save_json()
			 return {}
	
	file.open(file_path_+file_name_+".json", File.READ)
	var data = parse_json(file.get_as_text())
	return data

