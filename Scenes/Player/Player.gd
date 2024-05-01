extends CharacterBody2D

@onready var fsm : FiniteStateMachine = $FiniteStateMachine

func _ready() -> void:
	fsm.Initialize(self)

