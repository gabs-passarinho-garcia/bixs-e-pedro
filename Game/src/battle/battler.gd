extends BasePlayer

class_name Battler

signal turn_given
signal turn_finished

signal do

func _ready():
	connect("do", self, "_on_Battler_do")
	set_process_input(false)

func _input(event):
	print('nhe2_' + player_name)
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_A:
			print("Executed action")
			set_process_input(false)
			emit_signal("do")

func _process(delta):
	# print(delta)
	pass

func is_type(type): return type == "Battler" or .is_type(type)

func take_turn():
	print("Took turn")
	set_process_input(true)
	
	yield(self, "do")
	
	print("Finished turn")
	emit_signal("turn_finished")

func _on_Battler_do():
	print('im lost')
