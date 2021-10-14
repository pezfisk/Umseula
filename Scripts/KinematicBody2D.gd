extends KinematicBody2D

const UP = Vector2(0, -1)
var motion = Vector2()
export var speed = 25
export var max_speed = 150
export var gravity = 10
export var jump_force = -300
var jump_count = 0
var jump = 2
export var max_fall_speed = 750

var dead = false
var jump_check = false

var nextlevel = false

var Debug = false

func _ready():
	$CollisionShape2D.disabled = true
	$NextLevel.visible = false
	$AnimatedSprite.play('Jump')
# warning-ignore:shadowed_variable
# warning-ignore:unused_variable
# warning-ignore:shadowed_variable
	var jump_check = false
# warning-ignore:unused_variable
# warning-ignore:shadowed_variable
	var dead = false
# warning-ignore:unused_variable
# warning-ignore:shadowed_variable
	var nextlevel = false
	

func _process(_delta):
	if Input.is_action_just_pressed("debug"):
		Debug = true
	if Input.is_action_just_pressed("dissableDebug"):
		Debug = false
		$Colision.disabled = false
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
			$AnimatedSprite.flip_h = true
			if is_on_floor() and not dead:
				$AnimatedSprite.play('Walk')

		elif Input.is_action_pressed("ui_left") and not dead:
			motion.x += -speed
			motion.x = max(motion.x, -max_speed)
			$AnimatedSprite.flip_h = false
			if is_on_floor() and not dead:
				$AnimatedSprite.play('Walk')
		
		if Debug == true and not _pressing_movement():
			motion.x = 0
		
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = jump_force
		else:
			$AnimatedSprite.play('Jump')
		if not _pressing_movement() and not dead:
			if is_on_floor():
				$AnimatedSprite.play('Idle')
				motion.x = lerp(motion.x, 0, 0.25)
			if not is_on_floor():
				motion.x = lerp(motion.x, 0, 0.05)
				$AnimatedSprite.play('Jump')
	
	if Input.is_action_just_pressed("NextLevelChangeSkin"):
		nextlevel()
	
	if Debug == true:
		$Colision.disabled = true
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

func _next_to_wall():
	return $RayCast/Left.is_colliding() or $RayCast/Right.is_colliding()

# warning-ignore:function_conflicts_variable
func nextlevel():
	dead = false
	nextlevel = true
	$Colision.disabled = true
	$CollisionShape2D.disabled = false
	$AnimatedSprite.visible = false
	$NextLevel.visible = true

func death():
	motion.y = -200
	dead = true
	$Particles2D.is_emitting()
	$Timer.start()
	$Colision.disabled = true
	$AnimatedSprite.play('Dead')

func _on_Timer_timeout():
	if dead == true:
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
