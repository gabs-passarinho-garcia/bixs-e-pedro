extends KinematicBody2D
class_name Player

export(int) var WALKSPEED = 200
export(int) var JUMPSPEED = 250
export(int) var GRAVITY = 250
export(int) var TERMINALVELOCITY = 600

var snap_vector = Vector2(0,0.5)
var floor_normal = Vector2(0,-1)
var linear_velocity = Vector2(0,0)


var player_name = ""
var health = 0
var mana = 0
var strength = 0
var equipped_weapon = ""
var equipped_armor = ""
var known_skills = []


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Player")
	player_name = Global.player_name
	health = Global.health
	mana = Global.mana
	strength = Global.strength
	equipped_weapon = Global.equipped_weapon
	equipped_armor = Global.equipped_armor
	known_skills = Global.known_skills
	known_skills = Global.known_skills
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	linear_velocity.x = 0
	if is_on_floor():
		linear_velocity.y = 0
	else:
		linear_velocity.y += GRAVITY*delta
	if linear_velocity.y > TERMINALVELOCITY:
		linear_velocity.y = TERMINALVELOCITY
	if Input.is_action_pressed("ui_left"):
		linear_velocity.x -= WALKSPEED
		$Sprite.flip_h = true
	if Input.is_action_pressed("ui_right"):
		linear_velocity.x += WALKSPEED
		$Sprite.flip_h = false
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	move_and_slide(linear_velocity,floor_normal)
	if linear_velocity.x == 0:
		$AnimationPlayer.play("Parado")
	elif $AnimationPlayer.current_animation != "Andando":
		$AnimationPlayer.play("Andando")
	pass
