extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 120
const FRICTION = 450
const ROLL_SPEED = 125

onready var animationPlayer = $AnimationPlayer

var velocity := Vector2.ZERO
var roll_vector := Vector2.ZERO
var right = true


func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		if (animationPlayer.get_current_animation() != "Jump"):
			if input_vector.x < 0:
				animationPlayer.play("RunLeft")
				right = false
			else:
				animationPlayer.play("RunRight")
				right = true
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		if (animationPlayer.get_current_animation() != "Jump"):
			if right == true:
				animationPlayer.play("IdleRight")
			else:
				animationPlayer.play("IdleLeft")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
	
	
	if Input.is_action_just_pressed("Jump"):
		animationPlayer.play("Jump")
		velocity = input_vector * ROLL_SPEED
		velocity = move_and_slide(velocity)
	

#enum {
#	MOVE,
#	ROLL
#}
#
#var state = MOVE
#var velocity := Vector2.ZERO
#var roll_vector := Vector2.DOWN 
#var has_jumped = false
#
#onready var animationPlayer = $AnimationPlayer
#
#func _physics_process(delta: float) -> void:
#	match state:
#		MOVE:
#			move_state(delta)
#		ROLL:
#			roll_state()
#
#func move_state(delta):
#	var input_vector = Vector2.ZERO
#	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
#	input_vector = input_vector.normalized()
#
#	if input_vector != Vector2.ZERO:
#		animationPlayer.play("Run")
#		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
#	else:
#		animationPlayer.play("Idle")
#		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
#
#	move()
#
#	if Input.is_action_just_pressed("Jump"):
#		state = ROLL
#
#func roll_state():
#	if has_jumped == false:
#		velocity = roll_vector * ROLL_SPEED
#		animationPlayer.play("Roll")
#		has_jumped = true
#		move()
#
#
#func move() -> void:
#	velocity = move_and_slide(velocity)
#
#
#func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
#	animationPlayer.stop()
