extends Node

class_name PlayerFactory

# const BaseWeaponNode = preload("res://src/items/weapon.tscn")
# const BaseArmorNode = preload("res://src/items/armor.tscn")

static func make_dummy_player() -> BasePlayer:
	var player = BasePlayer.new()
	player.player_name = "Dummy"
	player.health = 10
	player.mana = 5
	player.strength = 1
	player.equipped_weapon = WeaponFactory.make_wood_sword()
	player.equipped_armor = ArmorFactory.make_cloth()
	player.known_skills = []
	
	return player
