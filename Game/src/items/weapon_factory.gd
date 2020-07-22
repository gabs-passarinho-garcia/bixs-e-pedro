extends Node

class_name WeaponFactory

static func make_wood_sword() -> Weapon:
	var weapon = Weapon.new()
	weapon.damage = 1
	
	return weapon
