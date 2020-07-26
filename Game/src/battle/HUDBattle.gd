extends MarginContainer

signal selected_attack

onready var fire1 = get_node("VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer3/FireSelection/Background")
onready var fire2 = get_node("VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer3/FireSelection2/Background")
onready var fire3 = get_node("VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer3/FireSelection3/Background")
#onready var pAnimation : PathFollow2D = get_node("VBoxContainer/ViewportContainer/Path2D/PathFollow2D")
#onready var pSprite : PathFollow2D = get_node("VBoxContainer/ViewportContainer/Path2D/PathFollow2D/Sprite")
#onready var pAnimationPlay : AnimationPlayer = get_node("VBoxContainer/ViewportContainer/Path2D/PathFollow2D/AnimationPlayer2")

onready var soulBar1 : ProgressBar = get_node("VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/CenterContainer2/ProgressBar")
onready var soulText1 : Label = get_node("VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Label2")

var selection : int = 0
var animationWalk : bool = false
var animationBackWalk : bool = false
var animationBattle : bool = false

var startedBattle : bool = false
var startedBattleFrame : int = 0
var passedOnce = false

func _ready():
	update_fire_visib()
	# pAnimationPlay.connect("animation_finished", self, "_on_AnimationPlayer2_finished")

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_DOWN:
			selection = min(2, selection + 1)
		elif event.scancode == KEY_UP:
			selection = max(0, selection - 1)
		elif event.scancode == KEY_ENTER and selection == 0:
			# ATTACK!
			print("ATTACK!")
			emit_signal("selected_attack")
#			animationWalk = true
#			pAnimationPlay.play("Andando")
#			set_process_input(false)

	update_fire_visib()

func update_life(new_hp : int):
	soulBar1.value = min(soulBar1.max_value, new_hp)
	soulText1.text = str(soulBar1.value) + "/" + str(soulBar1.max_value)

func update_max_life(max_hp : int):
	soulBar1.max_value = max_hp
	soulText1.text = str(soulBar1.value) + "/" + str(soulBar1.max_value)

#func _process(delta):
#	if animationWalk:
#		if pAnimation.get_unit_offset() == 1:
#			animationWalk = false
#			pAnimationPlay.stop()
#			# pAnimationPlay.remove_animation("Andando")
#			animationBattle = true
#		pAnimation.set_unit_offset(pAnimation.get_unit_offset() + delta/2)
#	elif animationBattle:
#		if pAnimationPlay.is_playing():
#			if startedBattle:
#				startedBattleFrame = pAnimationPlay.current_animation_position
#				startedBattle = false
#			# if (pAnimationPlay.current_animation_position <= pAnimationPlay.current_animation_length - 0.02):
#			if (pAnimationPlay.current_animation_position <= startedBattleFrame + 0.02 and passedOnce):
#				pAnimationPlay.stop()
#				print("stopped battle")
#				animationBattle = false
#				pSprite.set_flip_h(true)
#				animationBackWalk = true
#				pAnimationPlay.play("Andando")
#			if (pAnimationPlay.current_animation_position <= startedBattleFrame + 0.02):
#				passedOnce = true
#		if not pAnimationPlay.is_playing():
#			print("started battle animation")
#			pAnimationPlay.play("Lutando")
#			startedBattle = true
#	elif animationBackWalk:
#		if pAnimation.get_unit_offset() == 0:
#			animationBackWalk = false
#			pAnimationPlay.stop()
#			pSprite.set_flip_h(false)
#			set_process_input(true)
#
#		pAnimation.set_unit_offset(pAnimation.get_unit_offset() - delta/2)
#		# set_process_input(true)
#
#func _on_AnimationPlayer2_finished(anim_name : String):
#	print("finished ", anim_name)
#	if (anim_name == "Lutando"):
#		pAnimationPlay.stop()
#		animationBattle = false
#		print("stopping ", anim_name, animationBattle)
#		pSprite.set_flip_h(true)
#		animationBackWalk = true
#
func update_fire_visib():
	fire1.visible = selection == 0;
	fire2.visible = selection == 1;
	fire3.visible = selection == 2;
