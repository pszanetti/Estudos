extends "res://Characters/NPC/PlayerDetection.gd"

onready var navigation = Global.navigation
onready var avaliable_destinations = Global.destinations

var motion: Vector2
var possible_destinations = []
var path = []
var destination: Vector2

export var nav_stop_threshold = 5
export var walk_speed = 0.5


func _ready() -> void:
	possible_destinations = avaliable_destinations.get_children()
#	print(possible_destinations)
#	call_deferred("make_path")
	make_path()

func _process(_delta: float) -> void:
	navigate()

func navigate() -> void:
	var distanc
	var distance_to_destination = position.distance_to(path[0])	
	destination = path[0]
	if distance_to_destination > nav_stop_threshold:
		move()
	else:
		update_path()

func update_path() -> void:
	if path.size() == 1:
		make_path()
	else:
		path.remove(0)

func move() -> void:
#	look_at(destination)
# 1. Calcula o vetor de direção até o próximo ponto do caminho
	var target_direction = (path[0] - global_position).normalized()
# 2. Descobre qual é o ângulo (em radianos) que o NPC precisa olhar
	var target_angle = target_direction.angle()	
# 3. Interpola suavemente o ângulo atual da rotação para o ângulo de destino
# O valor '0.1' (ou 'delta * 10') controla a velocidade da virada. Quanto menor, mais suave/lento.
	rotation = lerp_angle(rotation, target_angle, 0.1)
	motion = (destination - position).normalized() * MAX_SPEED * walk_speed
	if is_on_wall():
		make_path()
	move_and_slide(motion)

func make_path() -> void:
	randomize()
	var next_destination = possible_destinations[randi() % possible_destinations.size()]
	# Obtém o RID do mapa de navegação padrão do mundo 2D atual
	# Usa a nova instrução nativa do servidor recomendada pelo aviso
	path = navigation.get_simple_path(global_position, next_destination.global_position, false)
#	print(path)

