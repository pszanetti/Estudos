extends "res://Characters/NPC/PlayerDetection.gd"

onready var destinations = get_tree().get_root().find_node("Destinations", true, false)

var motion: Vector2 = Vector2.ZERO
var possible_destinations = []
var path: PoolVector2Array = []

export var minimum_arrival_distance: float = 5.0
export var walk_speed: float = 0.5
export var max_speed: float = 200.0

func _ready() -> void:
	randomize()
	if destinations:
		possible_destinations = destinations.get_children()
		print("Destinos encontrados: ", possible_destinations.size())
	else:
		print("ERRO: Nó 'Destinations' não encontrado na árvore.")
	
	call_deferred("make_path")


func _physics_process(_delta: float) -> void:
	if path.size() > 0:
		navigate()


func navigate() -> void:
	if path.empty():
		return
		
	var distance_to_destination = global_position.distance_to(path[0])    
	if distance_to_destination > minimum_arrival_distance:
		move()
	else:
		update_path()


func update_path() -> void:
	if path.size() <= 1:
		if $Timer.is_stopped():
			$Timer.start()
	else:
		path.remove(0)


func move() -> void:
	look_at(path[0])
	motion = (path[0] - global_position).normalized() * (max_speed * walk_speed)

	if is_on_wall():
		make_path()
	motion = move_and_slide(motion)


func make_path() -> void:
	if possible_destinations.empty():
		print("AVISO: Lista de destinos vazia!")
		return

	# Sorteia um nó da lista de destinos
	var dest_node = possible_destinations[randi() % possible_destinations.size()]
	
	# Garante que pegamos a posição global correta do Node2D/Position2D
	var target_pos = dest_node.global_position

	# Obtém o mapa de navegação global do mundo 2D
	var nav_map = get_world_2d().navigation_map

	# Busca o ponto mais próximo na malha gerenciada pelo TileMap
	var start_point = Navigation2DServer.map_get_closest_point(nav_map, global_position)
	var end_point = Navigation2DServer.map_get_closest_point(nav_map, target_pos)

	print("Origem (Guarda): ", global_position, " | Ponto Nav Mais Próximo: ", start_point)
	print("Destino (Alvo): ", target_pos, " | Ponto Nav Mais Próximo: ", end_point)

	# Solicita a rota ao servidor
	path = Navigation2DServer.map_get_path(nav_map, start_point, end_point, true)

	if path.empty():
		print("FALHA: O Navigation2DServer retornou um caminho vazio. Verifique se o TileMap e os Destinations estão exatamente sobre a malha de navegação verde.")
	else:
		print("Caminho gerado com sucesso! Tamanho do path: ", path.size())


func _on_Timer_timeout() -> void:
	make_path()
