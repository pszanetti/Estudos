extends "res://Characters/NPC/PlayerDetection.gd"

onready var navigation = Global.navigation
onready var avaliable_destinations = Global.destinations

var motion: Vector2
var possible_destinations = []
var path = []
var destination: Vector2

export var nav_stop_threshold = 5
export var walk_speed = 0.5
export var start_offset: int = 0  # Permite escolher no Inspector onde este guarda começa na rota

var current_index: int = 0

#### PARA E GIAR AO REDOR EM CADA POSITION2D
export var look_speed_deg = 90.0    # graus por segundo
export var look_min_deg = 180.0
export var look_max_deg = 360.0

var is_looking = false
var look_remaining = 0.0   # radianos que ainda faltam girar
var look_dir = 1
##############################################


func _ready() -> void:
	print(" Nova Versão ")
	randomize()
	possible_destinations = avaliable_destinations.get_children()

	if possible_destinations.size() > 0:
# Define o ponto de partida na ordem com base no offset do Inspector
		current_index = start_offset % possible_destinations.size()
	yield(get_tree(), "physics_frame")
	yield(get_tree(), "physics_frame")
	make_path()


func _process(delta: float) -> void:
	if is_looking:
		do_look(delta)
	elif path.size() > 0:
		navigate()
	
#	if path.size() > 0:
#		navigate()
##### Para parar e olhar ao redor
#######################################
func start_look() -> void:
	is_looking = true
	motion = Vector2.ZERO
	look_dir = 1 if randi() % 2 == 0 else -1
	look_remaining = deg2rad(rand_range(look_min_deg, look_max_deg))

func do_look(delta: float) -> void:
	var step = deg2rad(look_speed_deg) * delta
	step = min(step, look_remaining)
	rotation += look_dir * step
	look_remaining -= step
	if look_remaining <= 0.0:
		finish_look()

func finish_look() -> void:
	is_looking = false
	current_index = (current_index + 1) % possible_destinations.size()
	make_path()
#########################################
##########################################	
	



func navigate() -> void:
	var distance_to_destination = global_position.distance_to(path[0])    
	destination = path[0]
	if distance_to_destination > nav_stop_threshold:
		move()
	else:
		update_path()

func update_path() -> void:
	# Se chegou ao final do caminho atual (chegou no Position2D)
	if path.size() <= 1:
		path = []          # impede o navigate() de rodar enquanto observa
		start_look()
	else:
		path.remove(0)
## Se chegou ao final do caminho atual (chegou no Position2D)
#	if path.size() <= 1:
## Avança para o próximo Position2D na ordem (0 -> 1 -> 2 -> 0...)
#		current_index = (current_index + 1) % possible_destinations.size()
#		make_path()
#	else:
#		path.remove(0)

func move() -> void:
# 1. Calcula o vetor de direção até o próximo ponto do caminho
	var target_direction = (path[0] - global_position).normalized()
# 2. Descobre qual é o ângulo (em radianos) que o NPC precisa olhar
	var target_angle = target_direction.angle()    
# 3. Interpola suavemente o ângulo atual da rotação para o ângulo de destino
	rotation = lerp_angle(rotation, target_angle, 0.1)

	motion = (destination - position).normalized() * MAX_SPEED * walk_speed

#	if is_on_wall():
## Se bateu na parede, força ir para o próximo destino da rota
#		current_index = (current_index + 1) % possible_destinations.size()
#		make_path()
	move_and_slide(motion)

func make_path() -> void:
	if possible_destinations.size() == 0:
		return

# Pega o destino da vez de forma SEQUENCIAL (em vez de usar randi())
	var next_destination = possible_destinations[current_index]

# Calcula o caminho usando a navegação do Global
	path = navigation.get_simple_path(global_position, next_destination.global_position, false)

# Segurança caso o path venha vazio por algum erro de mapa
	if path.size() == 0:
		current_index = (current_index + 1) % possible_destinations.size()
		make_path()

