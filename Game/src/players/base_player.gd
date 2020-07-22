extends Node

class_name BasePlayer

# const BasePlayerNode = preload("res://src/players/base_player.tscn")

signal life;

var player_name : String

var health : int
var mana : int

var strength : int

var equipped_weapon
var equipped_armor

var known_skills : Array

func _to_string():
	return player_name + ", HP: " + str(health) + ", MP: " + str(mana)

func death():
	emit_signal("life")

func check_if_alive() -> void:
	if health <= 0:
		death()

func base_attack() -> Attack:
	# Return an Attack based on the player's equipped weapon
	# and base stats
	var damage : Damage = Damage.new()
	damage.type = Damage.DamageType.PHYSICAL
	damage.value = equipped_weapon.damage + strength
	
	var attack : Attack = Attack.new()
	attack.damage = damage
	
	return attack

func skill_atack(skill : Skill, target : BasePlayer):
	pass

func receive_attack(attack : Attack):
	var received_damage : int = equipped_armor.absorb_damage(attack.damage)
	health -= received_damage
	
	check_if_alive()
