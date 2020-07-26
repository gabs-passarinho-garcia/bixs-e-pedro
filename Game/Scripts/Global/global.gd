extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player_name = "Dummy"
var health = 10
var mana = 5
var strength = 1
var equipped_weapon = "Weapon"
var equipped_armor = "cloth"
var known_skills = []
var player_class
var cena_atual


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func save_game(): #user://savegame.save
	var save_dict = {
		"health" : health,
		"mana" : mana,
		"strength" : strength,
		"equipped_weapon": equipped_weapon,
		"equipped_armor" : equipped_armor,
		"known_skills" : known_skills ,
		"cena_atual" : cena_atual,
		"playerClass" : player_class
		}
	var save_game = File.new() #user://savegame.save
	if not save_game.file_exists("res://scenes/menus/savegame.save"):
		save_game.open("res://scenes/menus/savegame.save", File.WRITE)
	else:
		save_game.open("res://scenes/menus/savegame.save", File.READ_WRITE)
	save_game.store_line(to_json(save_dict))
	save_game.close()
	return
	pass

func game_load():
	var content = ""
	var file = File.new()
	if file.file_exists("res://scenes/menus/savegame.save"):
		file.open("res://scenes/menus/savegame.save", file.READ)
		content = file.get_as_text()
		file.close()
	else:
		return null
	var result = JSON.parse(content)
	var dict = result.result
	if (dict):
		health = dict.health
		mana = dict.mana
		strength = dict.strength
		equipped_weapon = dict.equipped_weapon
		equipped_armor = dict.equipped_armor
		cena_atual = dict.cena_atual
		player_class = dict.player_class
		get_tree().change_scene(cena_atual)
	else:
		print("Error: wrong JSON format, Screwed up loser")
		return null
	pass
