class_name QuestifyQueryValueParser extends RefCounted


static func parse(value: Variant, quest: QuestResource) -> Variant:
	if value is String:
		var trimmed_value: String = value.strip_edges()
		# if it's a single param, we DO care about the returned type
		if trimmed_value.length() > 2 and trimmed_value.match("{*}"):
			var param: String = trimmed_value.substr(1, trimmed_value.length() - 2)
			if quest.params.has(param):
				return quest.params[param]
		# handle resource path
		elif trimmed_value.begins_with("res://") and ResourceLoader.exists(trimmed_value):
			return load(trimmed_value)
		# just create a string with all params replaced
		else:
			return value.format(quest.params)
	return value
