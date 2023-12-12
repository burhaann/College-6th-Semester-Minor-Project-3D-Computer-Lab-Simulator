extends Spatial

onready var anim = $AnimationPlayer
onready var tim = $Timer
#onready var blend = Anim["parameter/BlendSpace2D/blendposition"]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Idle")
	pass # Replace with function body.


#Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RandomAnim_button_down():
	play_random_animation(anim)
	pass # Replace with function body.
	
func play_random_animation(animation_player:AnimationPlayer):
	randomize()
	var animation_list = animation_player.get_animation_list()
	var random_animation = animation_list[randi() % animation_list.size()]
	randomize()
	animation_player.play(random_animation)


func _on_Reset_button_down():
	anim.play("Idle")
	pass # Replace with function body.


func _on_Play_button_down():
	anim.play("Idle")
	pass # Replace with function body.
