extends Node2D


onready var guerreiro_button = $Guerreiro
onready var mago_button = $Mago
onready var rogue_button = $Rogue


# Called when the node enters the scene tree for the first time.
func _ready():
	guerreiro_button.connect("button_down",self,"on_guerreiro_down")
	mago_button.connect("button_down",self,"on_mago_down")
	rogue_button.connect("button_down",self,"on_rogue_down")
	
	
	pass # Replace with function body.

func inicio():
	get_tree().change_scene("res://scenes/Levels/Teste.tscn")
	pass

func on_guerreiro_down():
	Global.player_class = "res://scenes/characters/Player/Player1.tscn"
	inicio()
	pass
	
func on_mago_down():
	Global.player_class = "res://scenes/characters/Player/Player2.tscn"
	inicio()
	pass
	
func on_rogue_down():
	Global.player_class = "res://scenes/characters/Player/Player3.tscn"
	inicio()
	pass
