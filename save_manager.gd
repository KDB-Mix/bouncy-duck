extends Node

var filePath = "user://save.dat"
var saveData: Dictionary = {}

const score_key = "SCORE"
const key_base64 = "anVzdCBhIGxpbCBzZWN1cmUgcGFzcw=="


func _ready() -> void:
	load_data()

func load_data():
	#var file = FileAccess.open_encrypted_with_pass(filePath, FileAccess.READ, Marshalls.base64_to_utf8(key_base64))
	var file = FileAccess.open_encrypted_with_pass(filePath, FileAccess.READ, Marshalls.base64_to_utf8(key_base64))
	if file:
		var file_data = JSON.parse_string(file.get_as_text())
		file.close()
		if file_data:
			saveData = file_data
			initialize_defaults()
		else:
			initialize_defaults()
	else:
		initialize_defaults()
func initialize_defaults():
	saveData.get_or_add(score_key, 0)
	save_file()

func save_file():
	#var file = FileAccess.open_encrypted_with_pass(filePath, FileAccess.WRITE, Marshalls.base64_to_utf8(key_base64))
	var file = FileAccess.open_encrypted_with_pass(filePath, FileAccess.WRITE, Marshalls.base64_to_utf8(key_base64))
	if file:
		var saveDataString = JSON.stringify(saveData, "\t")
		file.store_string(saveDataString)
		file.close()
	else:
		initialize_defaults()
		
func save_score(new_score: int) -> bool:
	if saveData.get_or_add(score_key, 0) < new_score:
		saveData.set(score_key, new_score)
		save_file()
		return true
	return false
