extends Node

class_name ArmorFactory

static func make_cloth() -> Armor:
	var armor = Armor.new()
	armor.physical_defense = 1
	armor.magical_defense = 1
	
	return armor
