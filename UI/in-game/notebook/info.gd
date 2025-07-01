extends MarginContainer

@onready var info_name = $info/Label
@onready var info_content = $info/Label2

func update(data : Dictionary) -> void:
	if !data:
		info_name.text = ""
		info_content.text = ""
	else:
		info_name.text = data["name"]
		info_content.text = ""
		for tidbit in data["info"]:
			info_content.text += tidbit + "\n"
