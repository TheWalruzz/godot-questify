class_name QuestifySettings extends RefCounted


const POLLING_ENABLED_PROJECT_SETTING = "questify/general/update_polling"
const POLLING_INTERVAL_PROJECT_SETTING = "questify/general/update_interval"
const ADD_QUESTS_TO_POT_GENERATION_SETTING = "questify/general/add_quests_to_pot_generation"


static var polling_enabled: bool:
	get: return ProjectSettings.get_setting(POLLING_ENABLED_PROJECT_SETTING) as bool


static var polling_interval: float:
	get: return ProjectSettings.get_setting(POLLING_INTERVAL_PROJECT_SETTING) as float


static var add_quests_to_pot_generation: float:
	get: return ProjectSettings.get_setting(ADD_QUESTS_TO_POT_GENERATION_SETTING) as float


static func init_settings() -> void:
	if not ProjectSettings.has_setting(POLLING_ENABLED_PROJECT_SETTING):
		ProjectSettings.set_setting(POLLING_ENABLED_PROJECT_SETTING, true)

	if not ProjectSettings.has_setting(POLLING_INTERVAL_PROJECT_SETTING):
		ProjectSettings.set_setting(POLLING_INTERVAL_PROJECT_SETTING, 0.5)

	if not ProjectSettings.has_setting(ADD_QUESTS_TO_POT_GENERATION_SETTING):
		ProjectSettings.set_setting(ADD_QUESTS_TO_POT_GENERATION_SETTING, false)
