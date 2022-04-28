extends KinematicBody2D


enum {
	MOVE
}
var can_fire = true
var input_vector = Vector2.ZERO
var velocity = Vector2.ZERO
var state = MOVE

export var speed : float = 4
const SPEED := Global.speed
export var ACCELERATION = 6000
export var MAX_SPEED = Global.speed
export var FRICTION = 6000
export var BULLET_SCENE = preload("res://Player/Attack/Bullet_Normal.tscn")

onready var hurtbox = $HurtBoxPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var timer = get_node("Timer_Shot")

export (NodePath) var joystickLeftPath
onready var joystickLeft : VirtualJoystick

func _ready():
	var _error = PlayerStats.connect("no_health", self, "queue_free")

func _process(delta: float) -> void:
# 	Movement using the joystick output:
	if joystickLeft and joystickLeft.is_pressed():
		position += joystickLeft.get_output() * speed * delta
	
		#Movement using Input functions:
	#var move := Vector2.ZERO
	#move.x = Input.get_axis("ui_left", "ui_right")
	#move.y = Input.get_axis("ui_up", "ui_down")
	#position += move * speed * delta
	

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)

#Moviment Player
func move_state(delta):
	#Movimentação
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector) 
		animationTree.set("parameters/Move/blende_position", input_vector)
		animationState.travel("Move")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move()
	#if Input.is_action_pressed("ui_attack"):
	if can_fire == true:
		fire()
func move():
	velocity = move_and_slide(velocity)
#Shot Player
func fire():
	var roc = BULLET_SCENE.instance()
	get_tree().get_root().add_child(roc)
	roc.global_position = $Sprite.global_position + Vector2(0,-40)#bullet_position.global_position
	var dir = Vector2.ZERO
	dir += dir + Vector2(0,-1.5)
	roc.direction = dir
	can_fire = false
	timer.set_wait_time(Global.shot_speed)
	timer.start()

func _on_Timer_Shot_timeout():
	can_fire = true


func _on_VisibilityNotifier2D_screen_exited():
	pass


func _on_HurtBoxPlayer_area_entered(area):
	#if hurtbox.invincible == false:
	if Global.defense > 0:
		if area.damage > Global.data.Defense:
			area.damage -= Global.data.Defense 
			Global.data.Defense = 0
			PlayerStats.health -= area.damage
		if area.damage <= Global.data.Defense:
			Global.data.Defense -= area.damage
	else:
		PlayerStats.health -= area.damage
	Global.reload()
	Global.emit_signal("defense_changed")
	#PlayerStats.health += Global.defense
		#hurtbox.start_invincibility(0.6)
		#hurtbox.create_hit_effect()
		#var playerHurtSound = PlayerHurtSound.instance()
		#get_tree().current_scene.add_child(playerHurtSound)
		#frameFreezer(0.2, 0.5)
