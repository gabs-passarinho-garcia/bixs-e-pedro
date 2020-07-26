# Responsible for transitions between the main game screens:
# combat, game over, and the map
extends Node

signal combat_started

const battle_arena_scene = preload("res://src/battle/BattleArena.tscn")
# onready var transition = $Overlays/TransitionColor
# onready var local_map = $LocalMap
onready var party = $Party as Party
# onready var music_player = $MusicPlayer
# onready var game_over_interface := $GameOverInterface
# onready var gui := $GUI

var transitioning = false
var battle_arena: BattleArena


func _ready():
	print("entering battle")
	enter_battle($Formation)


func enter_battle(formation: Formation):
	print("inside battle")
	# Plays the combat transition animation and initializes the combat scene
	if transitioning:
		return

	# gui.hide()
	# music_player.play_battle_theme()

	transitioning = true
	# yield(transition.fade_to_color(), "completed")

	# remove_child(local_map)
	battle_arena = battle_arena_scene.instance()
	add_child(battle_arena)
	battle_arena.connect("victory", self, "_on_CombatArena_player_victory")
	battle_arena.connect("game_over", self, "_on_CombatArena_game_over")
	battle_arena.connect(
		"battle_completed", self, "_on_CombatArena_battle_completed", [battle_arena]
	)
	battle_arena.initialize(formation, party.get_active_members())

	# yield(transition.fade_from_color(), "completed")
	transitioning = false

	battle_arena.battle_start()
	emit_signal("combat_started")


func _on_CombatArena_battle_completed(arena):
	# At the end of an encounter, fade the screen, remove the combat arena
	# and add the local map back
	# gui.show()

	transitioning = true
	# yield(transition.fade_to_color(), "completed")
	battle_arena.queue_free()

	# add_child(local_map)
	# yield(transition.fade_from_color(), "completed")
	transitioning = false
	# music_player.stop()


func _on_CombatArena_player_victory():
	# music_player.play_victory_fanfare()
	pass


func _on_CombatArena_game_over() -> void:
	transitioning = true
	# yield(transition.fade_to_color(), "completed")
	# game_over_interface.display(GameOverInterface.Reason.PARTY_DEFEATED)
	# yield(transition.fade_from_color(), "completed")
	transitioning = false


func _on_GameOverInterface_restart_requested():
	# game_over_interface.hide()
	var formation = battle_arena.initial_formation
	battle_arena.queue_free()
	enter_battle(formation)
