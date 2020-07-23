extends Node

class_name Battle

const BasePlayerNode = preload("res://src/players/player.tscn")

onready var queue = preload("res://src/battle/queue.tscn")

var players : Array
var enemies : Array
var node_queue : BattleQueue

var rng = RandomNumberGenerator.new()

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_A:
			self.add_child(queue.instance())
			print("Created queue. Children:", self.get_children())
			print("Checking Queue:", get_node("BattleQueue"))
			
			node_queue = get_node("BattleQueue")
			node_queue.start_filling_queue()
			print("Started Filling Queue")
			
		elif event.scancode == KEY_P:
			var player = BattlerFactory.make_battler("Player_" + str(len(players)))
			players.append(player)
			node_queue.add_to_queue([rng.randi_range(0, 10), player])
			
			print("Players:", players)
		elif event.scancode == KEY_E:
			var enemy = BattlerFactory.make_battler("Enemy_" + str(len(enemies)))
			enemies.append(enemy)
			node_queue.add_to_queue([rng.randi_range(0, 10), enemy])
			
			print("Enemies:", enemies)
		elif event.scancode == KEY_S:
			node_queue.stop_filling_queue()
			print("Stopped Filling Queue")
			
			print("Started Battle!")
			print("Creating signals")
			for player in players:
				player.connect("life", self, "died_player", [player])
			for enemy in enemies:
				enemy.connect("life", self, "died_enemy", [enemy])
			
			print("Queue:", node_queue.print_queue())
			
		elif event.scancode == KEY_X:
			while not node_queue.empty():
				var battler : Battler = node_queue.pop_from_queue()
				print("Battler:", battler)
			#if len(players) > 0:
			#	for enemy in enemies:
			#		enemy.receive_attack(players[0].base_attack())
			#print("Enemies after attack:", enemies)

func died_player(player : BasePlayer):
	print(player, " is dead.")
	players.erase(player)

func died_enemy(enemy : BasePlayer):
	print(enemy, " is dead.")
	enemies.erase(enemy)
	print("Enemies after death:", enemies)
