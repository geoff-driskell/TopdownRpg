extends State
class_name PlayerWalking

@export var walk_speed : int = 350

@export var animator : AnimationTree
@export var effect_animator : AnimationTree
@onready var anim_state_machine : AnimationNodeStateMachinePlayback = animator.get("parameters/playback")


func Enter():
	anim_state_machine.travel("Walk")

func Update(_delta: float):
	var input_direction : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()

	if input_direction:
		player.velocity = input_direction * walk_speed
		animator.set("parameters/Idle/blend_position", input_direction)
		animator.set("parameters/Walk/blend_position", input_direction)
		animator.set("parameters/Attack/blend_position", input_direction)
		animator.set("parameters/Stunned/blend_position", input_direction)
		effect_animator.set("parameters/Attack/blend_position", input_direction)
		player.move_and_slide()
	else:
		state_transition.emit(self, "idle")

	if Input.is_action_just_pressed("attack"):
		state_transition.emit(self, "attack")