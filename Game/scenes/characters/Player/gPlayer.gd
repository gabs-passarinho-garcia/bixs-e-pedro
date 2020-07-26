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
var soul = 0
var equipped_weapon = ""
var equipped_armor = ""
var known_skills = []
var player_class


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Player")
	player_name = Global.player_name
	soul = Global.soul
	equipped_weapon = Global.equipped_weapon
	equipped_armor = Global.equipped_armor
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
		$andando.flip_h = true
	if Input.is_action_pressed("ui_right"):
		linear_velocity.x += WALKSPEED
		$Sprite.flip_h = false
		$andando.flip_h = false
	if Input.is_action_pressed("ui_cancel"):
		$CanvasLayer/pause_menu.show()
		$CanvasLayer/pause_menu/AudioStreamPlayer2D.play()
		get_tree().paused = true
		
	move_and_slide(linear_velocity,floor_normal)
	if linear_velocity.x == 0:
		$AnimationPlayer.play("Parado")
	elif $AnimationPlayer.current_animation != "Andando":
		$AnimationPlayer.play("Andando")
	pass
