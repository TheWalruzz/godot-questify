@tool
extends EditorPlugin


const QuestResourceTranslationParser = preload("./quest_resource_translation_parser.gd")


var plugin: EditorTranslationParserPlugin


func _enter_tree() -> void:
	plugin = QuestResourceTranslationParser.new()
	add_translation_parser_plugin(plugin)


func _exit_tree() -> void:
	remove_translation_parser_plugin(plugin)
