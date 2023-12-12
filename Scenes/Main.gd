extends Spatial

onready var target = get_node("Ajx2/Armature/Skeleton")
onready var full = get_node("CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/Fullscreen")
onready var play = get_node("CanvasLayer/MarginContainer/VBoxContainer/HBContainer3/Play")
onready var reset = $CanvasLayer/MarginContainer/VBoxContainer/HBContainer2/Reset

var speed : float
var pressed = true
var clicked = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	play.grab_focus()
	pass # Replace with function body.




func _process(delta):
   global_transform.origin = lerp(global_transform.origin, target.global_transform.origin, delta*speed)
   var current_rotation = Quat(global_transform.basis)
   var next_rotation = current_rotation.slerp(Quat(target.global_transform.basis), delta*speed)
   global_transform.basis = Basis(next_rotation)


#func _input(event):
#	if Input.is_action_just_pressed("Fullscreen"):
#		OS.window_fullscreen = !OS.window_fullscreen



func _on_Play_button_down():
	$CanvasLayer/MarginContainer.hide()
	background_loadings.dark = true
	background_loadings.dark_theme()
	background_loadings.load_scene("res://Scenes/Spatial.tscn")
#	get_tree().change_scene("res://Scenes/Spatial.tscn")
	pass # Replace with function body.


func _on_Exit_button_down():
	get_tree().quit()
	pass # Replace with function body.


func _on_RandomAnim_button_down():
	reset.show()
	pass # Replace with function body.



func _on_Fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	if (pressed == true):
		full.texture_normal = load("res://Textures/128/Full (1).png")
		full.texture_pressed = load("res://Textures/128/Full (3).png")
		pressed = false
	else:
		full.texture_normal = load("res://Textures/128/Full (4).png")
		full.texture_pressed = load("res://Textures/128/Full (3).png")
		pressed = true
	pass # Replace with function body.



func _on_Reset_button_up():
	if (clicked > 1):
		reset.visible = false
		clicked = 0
	clicked += 1
	pass # Replace with function body.
