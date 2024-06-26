extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()
var speed : int
var max_speed : int
var gravity : int
var jump_force : int
var max_fall_speed : int
var jump_count = 0
var jump = 2

var dead = false
var jump_check = false
var nextlevel = false

var Debug = false

onready var AnimS = $AnimatedSprite
onready var col = $Collision

func _ready():
	speed = GLOBALS.speed
	max_speed = GLOBALS.max_speed
	gravity = GLOBALS.gravity
	jump_force = GLOBALS.jump_force
	max_fall_speed = GLOBALS.max_fall_speed
	$NextLevel.visible = false
	AnimS.play('Jump')

func _process(_delta):
	
	GLOBALS.player_pos = self.global_position
	
	if Input.is_action_just_pressed("debug"):
		Debug = true
	if Input.is_action_just_pressed("dissableDebug"):
		Debug = false
		col.disabled = false
	if Input.is_action_just_pressed("dead") and dead == false:
		death()

func _physics_process(_delta):
	if Debug == false:
		motion.y += gravity
		motion.y = min(motion.y, max_fall_speed)
	
	if not dead and not nextlevel:
		if Input.is_action_pressed("ui_right") and not dead:
			motion.x += speed
			motion.x = min(motion.x, max_speed)
			AnimS.flip_h = true
			if is_on_floor() and not dead:
				AnimS.play('Walk')
		
		if Input.is_action_pressed("ui_left") and not dead:
			motion.x += -speed
			motion.x = max(motion.x, -max_speed)
			AnimS.flip_h = false
			if is_on_floor() and not dead:
				AnimS.play('Walk')
		
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = jump_force
		else:
			AnimS.play('Jump')
		if not _pressing_movement() and not dead:
			if is_on_floor():
				AnimS.play('Idle')
				motion.x = lerp(motion.x, 0, 0.25)
			else:
				motion.x = lerp(motion.x, 0, 0.05)
				AnimS.play('Jump')
		
		if Debug == true and not _pressing_movement():
			motion.x = 0
		
	
	if Input.is_action_just_pressed("NextLevelChangeSkin"):
		nextlevel()
	
	if Debug == true:
		col.disabled = true
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -200
		if Input.is_action_just_pressed("ui_down"):
			motion.y = 200
		if not _pressing_movement_vertical():
			motion.y = 0
	
	motion = move_and_slide(motion, UP)

func _pressing_movement():
	return Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")

func _pressing_movement_vertical():
	return Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")

#func _next_to_wall():
	#return $RayCast/Left.is_colliding() or $RayCast/Right.is_colliding()

# warning-ignore:function_conflicts_variable
func nextlevel():
	dead = false
	nextlevel = true
	AnimS.visible = false
	$NextLevel.visible = true

func death():
	col.disabled = true
	motion.y = -200
	dead = true
	$Timer.start()
	AnimS.play('Dead')

func _on_Timer_timeout():
	if dead == true:
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
