class_name QuestifyNanoIdGenerator extends RefCounted


const ALPHABET := "useandom-26T198340PX75pxJACKVERYMINDBUSHWOLF_GQZbfghjklqvwyzrict"
const DEFAULT_LENGTH := 21


static func generate(length := DEFAULT_LENGTH) -> String:
	var id: String = ""
	for i in range(length):
		id += ALPHABET[randi() % ALPHABET.length()]
	return id
