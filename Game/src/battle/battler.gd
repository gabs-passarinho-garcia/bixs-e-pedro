extends Position2D

class_name Battler

signal turn_given
signal turn_finished

signal do

export var TARGET_OFFSET_DISTANCE: float = 120.0

var target_global_position: Vector2

var selected: bool = false setget set_selected
var selectable: bool = false setget set_selectable

export var stats: Resource
export var party_member = false

onready var meshes = $Meshes

func _ready():
	connect("do", self, "_on_Battler_do")
	set_process_input(false)
	
	var direction: Vector2 = Vector2(1.0, 0.0) if party_member else Vector2(-1.0, 0.0)
	target_global_position = $TargetAnchor.global_position + direction * TARGET_OFFSET_DISTANCE
	selectable = true


func initialize():
	meshes.initialize()
	# actions.initialize(skills.get_children())
	stats = stats.copy()
	stats.connect("health_depleted", self, "_on_health_depleted")

func _input(event):
	print('nhe2_' + "2")
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

func is_able_to_play() -> bool:
	# Returns true if the battler can perform an action
	return stats.health > 0


func set_selected(value):
	selected = value
	# skin.blink = value


func set_selectable(value):
	selectable = value
	if not selectable:
		set_selected(false)

func appear():
	var offset_direction = 1.0 if party_member else -1.0
	meshes.position.x += TARGET_OFFSET_DISTANCE * offset_direction
	meshes.appear()
