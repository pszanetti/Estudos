extends "res://Characters/NPC/PlayerDetection.gd"

onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var destinations = get_tree().get_root().find_node("Destinations", true, false)

var motion: Vector2
var possible_destinations
var path: PoolVector2Array

func _ready() -> void:
	randomize()
	if destinations:
		possible_destinations = destinations.get_children()
	make_path()

func make_path() -> void:
	if possible_destinations.size() == 0 or not navigation:
		return
		
	# Sorteia um destino aleatório entre os filhos de Destinations
	var target = possible_destinations[randi() % possible_destinations.size()]
	
	# Calcula o caminho usando o Navigation2D clássico
	path = navigation.get_simple_path(global_position, target.global_position)

func _physics_process(delta: float) -> void:
	if path.size() > 0:
		var target_point = path[0]
		var distance = global_position.distance_to(target_point)
		
		# Calcula a direção e aplica o SPEED herdado do PlayerDetection
		var direction = global_position.direction_to(target_point)
		motion = direction * SPEED * 10
		
		
		# Movimentação do corpo
		if has_method("move_and_slide"):
			move_and_slide(motion)
		else:
			position += motion * delta
		if is_on_wall():
			make_path()
		
		# Se chegou perto o suficiente do ponto atual, remove ele da fila
		if distance < 5.0:
			path.remove(0)
			# Se a lista esvaziou, sorteia um novo destino
			if path.size() == 0:
				make_path()
	else:
		motion = Vector2.ZERO
		make_path()
