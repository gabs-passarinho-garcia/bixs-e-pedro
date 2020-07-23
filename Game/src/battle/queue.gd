extends Node

class_name BattleQueue

var filling_queue : bool = false
var queue : Array = []  	# Array of Tuple<Int, Battler>	# Array of Tuple<Int, Battler>

func print_queue() -> String:
	return str(queue)

func empty() -> bool:
	return queue.empty()

func start_filling_queue():
	filling_queue = true
	queue = []

func stop_filling_queue():
	filling_queue = false
	order_queue()

func add_to_queue(battler : Array):
	if filling_queue:
		# TODO: Check if this is going to work
		if len(battler) == 2 and typeof(battler[0]) == 2 and battler[1].is_type("Battler"):
			queue.append(battler)
		else:
			print("Trying to add wrong types. Expected Array[int, Battler]")
	else:
		print("Queue must be opened to add")

static func sort_initiative_desc(a, b):
	if a[0] > b[0]:
		print(a[0], " > ", b[0])
		return true
	elif a[0] == b[0]:
		if a[1].agility > b[1].agility:
			print(a[1].agility, " > ", b[1].agility)
			return true
		elif a[1].agility == b[1].agility:
			return a[1].in_party
	
	return false

func order_queue():
	if not filling_queue:
		queue.sort_custom(self, "sort_initiative_desc")
		print("Sorting queue:", queue)
	else:
		print("Queue must be closed to sort")

func pop_from_queue() -> Battler:
	return queue.pop_front()[1]
