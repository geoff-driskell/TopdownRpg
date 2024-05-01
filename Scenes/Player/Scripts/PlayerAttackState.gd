extends State
class_name PlayerAttack

@export var animator : AnimationTree
@export var effect_animator : AnimationTree
@export var audio_player : AudioStreamPlayer2D
@export var attack_sound : AudioStream
@onready var anim_state_machine : AnimationNodeStateMachinePlayback = animator.get("parameters/playback")
@onready var effect_state_machine : AnimationNodeStateMachinePlayback = effect_animator.get("parameters/playback")

var attacking : bool

func Enter() -> void:
	anim_state_machine.travel("Attack")
	effect_state_machine.travel("Attack")
	animator.animation_finished.connect(EndAttack)
	audio_player.stream = attack_sound
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	audio_player.play()
	attacking = true

func Exit():
	animator.animation_finished.disconnect(EndAttack)

func EndAttack(_new_anim_name : String):
	attacking = false
	effect_state_machine.travel("attack_none")
	state_transition.emit(self, "idle")
