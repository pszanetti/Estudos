extends "res://Characters/TemplateCharacter.gd"

var motion: Vector2

const PLAYER_SPRITE = "res://GFX/PNG/Hitman 1/hitman1_stand.png"
const BOX_SPRITE = "res://GFX/PNG/Tiles/tile_129.png"
const PLAYER_OCCLUDER = "res://Characters/PlayerOcluder.tres"
const BOX_OCCLUDER = "res://Characters/BoxOcluder.tres"
const PLAYER_COLLISION_SHAPE = "res://Characters/PlayerCollisionCapsule.tres"
const BOX_COLLSION_SHAPE = "res://Characters/BoxCollision.tres"

var disguised = false
export var disguise_slowdown = 0.25
export var disguise_duration = 5.0
export var number_of_disguises = 3

var velocity_multiplier = 1


func _ready() -> void:
	Global.Player = self
	$Timer.wait_time = disguise_duration
	get_tree().call_group("DisguiseDisplay", "update_disguises", number_of_disguises)
	reveal()

#onready var torch: Light2D = $Torch

func _physics_process(_delta: float) -> void:
	update_movement()
	move_and_slide(motion * velocity_multiplier)
	if disguised:
		$DisguiseLabel.text = str($Timer.time_left).pad_decimals(2)
		$DisguiseLabel.rect_rotation = - rotation_degrees
	
func update_movement() -> void:
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
	elif number_of_disguises > 0:
		disguise()
	pass


func reveal() -> void:
	$Sprite.texture = load(PLAYER_SPRITE)
	$Light2D.texture = load(PLAYER_SPRITE)
	$LightOccluder2D.occluder = load(PLAYER_OCCLUDER)
	$CollisionShape2D.shape = load(PLAYER_COLLISION_SHAPE)
	$DisguiseLabel.visible = false
	disguised = false
	collision_layer = 1
	velocity_multiplier = 1
	
func disguise() -> void:
	number_of_disguises -= 1
	get_tree().call_group("DisguiseDisplay", "update_disguises", number_of_disguises)
	$Timer.start()
	$Sprite.texture = load(BOX_SPRITE)
	$Light2D.texture = load(BOX_SPRITE)
	$LightOccluder2D.occluder = load(BOX_OCCLUDER)
	$CollisionShape2D.shape = load(BOX_COLLSION_SHAPE)
	$DisguiseLabel.show()
	collision_layer = 16
	disguised = true
	velocity_multiplier = disguise_slowdown
	
func collect_briefcase() -> void:
	var loot = Node.new()
	loot.set_name("Briefcase")
	add_child(loot)
	get_tree().call_group("Loot", "collect_loot")
	get_tree().call_group("Exit", "show")
	pass
	
