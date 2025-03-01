@tool
extends EditorTranslationParserPlugin


func _parse_file(path: String):
	var msgids: Array[PackedStringArray] = []
	var resource: Resource = load(path)

	if resource is QuestResource:
		for node in resource.nodes:
			if node is QuestObjective:
				msgids.append(PackedStringArray([node.description]))
			if node is QuestStart:
				msgids.append(PackedStringArray([node.name]))
				msgids.append(PackedStringArray([node.description]))

	return msgids


func _get_recognized_extensions():
	return ["tres"]
