extends "res://Characters/NPC/PlayerDetection.gd"

onready var navigation = Global.navigation
onready var avaliable_destinations2 = Global.destinations2


var motion: Vector2
var possible_destinations2 = []
var path = []
var destination2: Vector2

export var nav_stop_threshold = 5
export var walk_speed = 0.5
export var start_offset: int = 0  # Permite escolher no Inspector onde este guarda começa na rota

var current_index: int = 0

func _ready() -> void:
	navigation = Global.navigation
	possible_destinations2 = avaliable_destinations2.get_children()

	if possible_destinations2.size() > 0:
		current_index = start_offset % possible_destinations2.size()

	# espera o NavigationServer sincronizar o mapa
	yield(get_tree(), "physics_frame")
	yield(get_tree(), "physics_frame")
	make_path()

func navigate() -> void:
	destination2 = path[0]
	if global_position.distance_to(destination2) > nav_stop_threshold:
		move()
	else:
		update_path()

func move() -> void:
	var target_direction = (destination2 - global_position).normalized()
	rotation = lerp_angle(rotation, target_direction.angle(), 0.1)
	motion = target_direction * MAX_SPEED * walk_speed
	move_and_slide(motion)

func make_path(tentativas: int = 0) -> void:
	if possible_destinations2.size() == 0 or tentativas >= possible_destinations2.size():
		push_warning("Guarda sem caminho válido: navmesh vazio ou desconectado")
		return

	var next_destination = possible_destinations2[current_index]
	path = navigation.get_simple_path(global_position, next_destination.global_position, false)

	if path.size() == 0:
		current_index = (current_index + 1) % possible_destinations2.size()
		make_path(tentativas + 1)

#func make_path() -> void:
#	if possible_destinations.size() == 0:
#		return
#
## Pega o destino da vez de forma SEQUENCIAL (em vez de usar randi())
#	var next_destination = possible_destinations[current_index]
#
## Calcula o caminho usando a navegação do Global
#	path = navigation.get_simple_path(global_position, next_destination.global_position, false)
#
## Segurança caso o path venha vazio por algum erro de mapa
#	if path.size() == 0:
#		current_index = (current_index + 1) % possible_destinations.size()
#		make_path()


func _process(_delta: float) -> void:
	if path.size() > 0:
		navigate()
func update_path() -> void:
# Se chegou ao final do caminho atual (chegou no Position2D)
	if path.size() <= 1:
# Avança para o próximo Position2D na ordem (0 -> 1 -> 2 -> 0...)
		current_index = (current_index + 1) % possible_destinations2.size()
		make_path()
	else:
		path.remove(0)
