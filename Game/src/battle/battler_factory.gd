extends Node

class_name BattlerFactory

# const BaseWeaponNode = preload("res://src/items/weapon.tscn")
# const BaseArmorNode = preload("res://src/items/armor.tscn")

static func make_battler(name : String = "Dummy") -> Battler:
	var rng : RandomNumberGenerator = RandomNumberGenerator.new()
	
	var battler = Battler.new()
	battler.player_name = name
	battler.health = 10
	battler.mana = 5
	battler.strength = 1
	battler.agility = rng.randi_range(1, 5)
	battler.equipped_weapon = WeaponFactory.make_wood_sword()
	battler.equipped_armor = ArmorFactory.make_cloth()
	battler.known_skills = []
	
	return battler
