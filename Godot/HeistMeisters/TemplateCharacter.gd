extends "res://Characters/TemplateCharacter.gd"

var motion: Vector2

const PLAYER_SPRITE = "res://GFX/PNG/Hitman 1/hitman1_stand.png"
const BOX_SPRITE = "res://GFX/PNG/Tiles/tile_129.png"
const PLAYER_OCCLUDER = "res://Characters/PlayerOcluder.tres"
const BOX_OCCLUDER = "res://Characters/BoxOcluder.tres"
var disguised = false
export var disguise_slowdown = 0.25

var velocity_multiplier = 1


func _ready() -> void:
	Global.Player = self
	pass

#onready var torch: Light2D = $Torch

func _physics_process(_delta: float) -> void:
	update_movement()
	move_and_slide(motion * velocity_multiplier)
	pass
	
func update_movement():
	# Olhar na direção do ponteiro do mouse
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("move_down"):
		motion.y = clamp(motion.y + SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("move_up"):
		motion.y = clamp(motion.y - SPEED, - MAX_SPEED, 0)
	else:
		motion.y = lerp(motion.y, 0, FRICTION)
		
	if Input.is_action_pressed("move_right"):
		motion.x = clamp(motion.x + SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("move_left"):
		motion.x = clamp(motion.x - SPEED, - MAX_SPEED, 0)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_vision_mode"):
		get_tree().call_group("Interface", "cyclo_vision_mode")
	if Input.is_action_just_pressed("toggle_disguises"):
		toggle_disguise()
		
func toggle_disguise() -> void:
	if disguised:
		reveal()
	else:
		disguise()
	pass


func reveal() -> void:
	$Sprite.texture = load(PLAYER_SPRITE)
	$Light2D.texture = load(PLAYER_SPRITE)
	$LightOccluder2D.occluder = load(PLAYER_OCCLUDER)
	disguised = false
	collision_layer = 1
	velocity_multiplier = 1
	
func disguise() -> void:
	$Sprite.texture = load(BOX_SPRITE)
	$Light2D.texture = load(BOX_SPRITE)
	$LightOccluder2D.occluder = load(BOX_OCCLUDER)
	collision_layer = 16
	disguised = true
	velocity_multiplier = disguise_slowdown
	
	
	
