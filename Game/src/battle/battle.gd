extends Node

class_name Battle

const BasePlayerNode = preload("res://src/players/player.tscn")

var players : Array
var enemies : Array

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_P:
			players.append(PlayerFactory.make_dummy_player())
			print("Players:", players)
		elif event.scancode == KEY_E:
			enemies.append(PlayerFactory.make_dummy_player())
			print("Enemies:", enemies)
		elif event.scancode == KEY_S:
			print("Started Battle!")
			print("Creating signals")
			for player in players:
				player.connect("life", self, "died_player", [player])
			for enemy in enemies:
				enemy.connect("life", self, "died_enemy", [enemy])
			
		elif event.scancode == KEY_X:
			if len(players) > 0:
				for enemy in enemies:
					enemy.receive_attack(players[0].base_attack())
			print("Enemies after attack:", enemies)

func died_player(player : BasePlayer):
	print(player, " is dead.")
	players.erase(player)

func died_enemy(enemy : BasePlayer):
	print(enemy, " is dead.")
	enemies.erase(enemy)
	print("Enemies after death:", enemies)
