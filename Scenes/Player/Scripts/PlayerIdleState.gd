extends State
class_name PlayerIdle

@export var animator : AnimationTree
@onready var anim_state_machine : AnimationNodeStateMachinePlayback = animator.get("parameters/playback")

func Enter():
    anim_state_machine.travel("Idle")
    pass

func Update(_delta : float):
    if Input.get_vector("move_left", "move_right", "move_down", "move_up").normalized():
        state_transition.emit(self, "walk")

    if Input.is_action_just_pressed("attack"):
        state_transition.emit(self, "attack")