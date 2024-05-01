extends State
class_name PlayerAttack

@export var animator : AnimationTree
@onready var anim_state_machine : AnimationNodeStateMachinePlayback = animator.get("parameters/playback")

var attacking : bool

func Enter() -> void:
	anim_state_machine.travel("Attack")
	animator.animation_finished.connect(EndAttack)
	attacking = true

func Exit():
	animator.animation_finished.disconnect(EndAttack)

func EndAttack(_new_anim_name : String):
	attacking = false
	state_transition.emit(self, "idle")
