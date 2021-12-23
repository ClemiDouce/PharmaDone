extends Node

const pharma_save_path = "user://pharma"

func get_config_data():
	var data_dict : Dictionary = {}
	var file = File.new()
	file.open("res://data/config_pc.csv", File.READ)
	while file.get_position() < file.get_len():
		var line = file.get_csv_line(";")
		var post_type = line[0]
		line.remove(0)
		data_dict[post_type] = line
	file.close()
	return data_dict
	
	
func pharma_to_json(file_name: String, content: Dictionary):
	var dir = Directory.new()
	if !dir.dir_exists(pharma_save_path):
		dir.make_dir(pharma_save_path)
	var file = File.new()
	file.open(pharma_save_path.plus_file(file_name) + ".json", File.WRITE)
	var content_json = JSON.print(content)
	file.store_string(content_json)
	file.close()
	
func get_all_pharma_files():
	var file_list = {}
	var directory = Directory.new()
	var file = File.new()
	var error = directory.open(pharma_save_path)
	if error == OK:
		directory.list_dir_begin(true)
		var file_name = directory.get_next()
		while (file_name != ""):
			if !directory.current_is_dir():
				var final_path = (directory.get_current_dir().plus_file(file_name))
				file.open(final_path, File.READ)
				var result = JSON.parse(file.get_as_text()).result
				file_list[file_name] = {"path": final_path, "label": result["name"]}
				file.close()
			file_name = directory.get_next()
	else:
		print("Error opening directory")
	return file_list
	
#var data_dict = {}
#	var dir = Directory.new()
#	var dir_name = "pharmadone"
#	var file_name = "config_android.csv"
#	var user_dir = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS).plus_file(dir_name)
#	var f_name = user_dir.plus_file(file_name)
#	print(f_name)
#	var fp_user = File.new()
#	fp_user.open(f_name, File.READ)
#	while fp_user.get_position() < fp_user.get_len():
#		var line = fp_user.get_csv_line(";")
#		var post_type = line[0]
#		line.remove(0)
#		data_dict[post_type] = line
#	fp_user.close()
#	return data_dict
