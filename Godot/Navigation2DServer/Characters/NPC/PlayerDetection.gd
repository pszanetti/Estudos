extends "res://Characters/TemplateCharacter.gd"

# Angulo de tolerancia -20 até +20
const FOV_TOLERANCE: int = 20
const RED: Color = Color(1.0, 0.25, 0.25)
const WHITE: Color = Color(1.0, 1.0, 1.0)
const MAX_DETECTION_RAGE = 640

var Player: KinematicBody2D

func _ready() -> void:
	# Localiza o player na raiz
	Player = get_node("/root").find_node("Player", true, false)
	pass
	
func _process(_delta: float) -> void:
	if Player_in_FOV() and Player_in_LOS():
		$Torch.color = RED
	else:
		$Torch.color = WHITE
	
	
func Player_in_FOV() -> bool:
	# NPC rotação para a direita em qualquer direção
	var npc_facing_direction: Vector2 = Vector2(1.0, 0.0).rotated(global_rotation)
	# Pega a posição do Player em relação a posição global do NPC e retorna um valor entre -1 e 1
	var direction_to_Player = (Player.global_position - global_position).normalized()
	
	# Verifica em valores absolutos se o angulo do Player em relação ao NPC é menor que a Tolerancia em radianos
	if abs(direction_to_Player.angle_to(npc_facing_direction)) < deg2rad(FOV_TOLERANCE):
		return true
	else:
		return false
	pass
# Verifica se o Player está fora do campo de visão da camera
func Player_in_LOS() -> bool:
	# get_world_2d verifica todos os Nodes do jogo
	# WORLD_2D -> Tudo que está no Jogo, sons, física, etc..
	# direct_space_state -> verifica todos os nodes de física verificando por areas de colisão
	# DIRECT_SPAE_STATE -> verifica tudo que tenha física e colisões
	var space = get_world_2d().direct_space_state
	# Verifica os obstáculos
	var LOS_obstacle = space.intersect_ray(global_position, Player.global_position, [self]
			, collision_mask)
	if not LOS_obstacle:
		return false
	# Verifica a distancia em relação ao player
	var distance_to_player = Player.global_position.distance_to(global_position)
	# Se está colidindo com o Player
	var Player_in_Range = distance_to_player < MAX_DETECTION_RAGE
	if LOS_obstacle.collider == Player and Player_in_Range:
		return true
	else:
		return false
	


	
