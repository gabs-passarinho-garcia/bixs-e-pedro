extends Node2D
class_name gLevel

var guerreiro = preload("res://scenes/characters/Player/Player1.tscn")
var mago = preload("res://scenes/characters/Player/Player2.tscn")
var rogue = preload("res://scenes/characters/Player/Player3.tscn")
var player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.player_class == "res://scenes/characters/Player/Player1.tscn":
		player = guerreiro.instance()
	elif Global.player_class == "res://scenes/characters/Player/Player2.tscn":
		player = mago.instance()
	elif Global.player_class == "res://scenes/characters/Player/Player3.tscn":
		player = rogue.instance()
	$Position2D.add_child(player)
	
	pass # Replace with function body.

func change_scene(next_scene):
	Global.player_name = player.player_name
	Global.soul = player.soul
	Global.equipped_weapon = player.equipped_weapon
	Global.equipped_armor = player.eqquiped_armor
	Global.known_skills = player.known_skills
	Global.player_class = player.player_class
	get_tree().change_scene(next_scene)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
