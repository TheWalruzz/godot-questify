class_name QuestEdge extends Resource


enum EdgeType {
	NORMAL,
	CONDITIONAL,
}


@export var from: QuestNode
@export var to: QuestNode
@export var edge_type: EdgeType
