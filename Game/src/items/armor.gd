extends Item

class_name Armor

var physical_defense : int
var magical_defense : int

func absorb_damage(damage : Damage) -> int:
	if damage.type == Damage.DamageType.PHYSICAL:
		return max(0, damage.value - physical_defense) as int
	elif damage.type == Damage.DamageType.MAGICAL:
		return max(0, damage.value - magical_defense) as int
	else:
		# ERROR
		return -1
