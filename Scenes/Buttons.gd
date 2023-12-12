extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var scene = preload("res://Scenes/Main.tscn")
#var sceneGD = preload("res://Scenes/Main.gd")
var toggle = false
var pressed = true
onready var full = get_node("CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer3/Control2/Fullscreen")
onready var restart = get_node("CanvasLayer/MarginContainer/VBoxContainer/HBoxMenu/Control/ColorRect/CenterContainer/HBoxContainer/Resume/Label")
onready var mainu = get_node("CanvasLayer/MarginContainer/VBoxContainer/HBoxMenu/Control/ColorRect/CenterContainer/HBoxContainer/MainMenu/Label")
onready var pause = get_node("CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer3/Control3/Pause")
onready var pauseMenu = get_node("CanvasLayer/MarginContainer/VBoxContainer/HBoxMenu/Control/ColorRect")
onready var exitButton = get_node("CanvasLayer/MarginContainer/VBoxContainer/Control/HBoxContainer3/Control/Exit")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Pause_pressed():
	if (toggle == false):
		get_tree().paused = true
		pause.texture_normal = load("res://Textures/128/Play (3).png")
		pause.texture_pressed = load("res://Textures/128/Play (4).png")
		pause.texture_hover = load("res://Textures/128/Play (1).png")
		pauseMenu.show()
		pause.grab_focus()
		full.visible = true
		full.pause_mode = Node.PAUSE_MODE_PROCESS
		toggle = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		get_tree().paused = false
		pause.texture_normal = load("res://Textures/128/Pause (3).png")
		pause.texture_pressed = load("res://Textures/128/Pause (4).png")
		pause.texture_hover = load("res://Textures/128/Pause (1).png")
		pauseMenu.hide()
		full.visible = false
		full.pause_mode = Node.PAUSE_MODE_INHERIT
		toggle = false
		full.pause_mode = Node.PAUSE_MODE_INHERIT
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pause.grab_focus()
		pause.release_focus()
	pass # Replace with function body.


func _on_Exit_pressed():
	get_tree().quit()
	pass # Replace with function body.


# warning-ignore:unused_argument
func _unhandled_key_input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			get_tree().paused = false
			self.pause_mode = Node.PAUSE_MODE_INHERIT
			full.visible = false
			full.pause_mode = Node.PAUSE_MODE_INHERIT
			toggle = false
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			pause.texture_normal = load("res://Textures/128/Pause (3).png")
			pause.texture_pressed = load("res://Textures/128/Pause (4).png")
			pause.texture_hover = load("res://Textures/128/Pause (1).png")
			pauseMenu.hide()
		elif Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			pause.texture_normal = load("res://Textures/128/Play (3).png")
			pause.texture_pressed = load("res://Textures/128/Play (4).png")
			pause.texture_hover = load("res://Textures/128/Play (1).png")
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			pauseMenu.show()
			pause.grab_focus()
			full.visible = true
			full.pause_mode = Node.PAUSE_MODE_PROCESS
			toggle = true
			self.pause_mode = Node.PAUSE_MODE_PROCESS
			get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Resume_pressed():
	pauseMenu.hide()
	get_tree().paused = false
	toggle = false
	full.visible = false
	full.pause_mode = Node.PAUSE_MODE_INHERIT
	self.pause_mode = Node.PAUSE_MODE_INHERIT
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pause.texture_normal = load("res://Textures/128/Pause (3).png")
	pause.texture_pressed = load("res://Textures/128/Pause (4).png")
	pause.texture_hover = load("res://Textures/128/Pause (1).png")
	pass # Replace with function body.




func _on_MainMenu_pressed():
#	mainu.text = "So Sorry"
#	restart.text = "TRY RESUME"
	pauseMenu.hide()
	background_loadings.dark = false
	background_loadings.light_theme()
	background_loadings.load_scene("res://Scenes/Main.tscn")
	get_tree().paused = false
#	self.queue_free()
#	get_tree().change_scene_to(scene)
#	background_loadings.load_scene("res://Scenes/Main.tscn")
	pass # Replace with function body.


func _on_Restart_pressed():
#	mainu.text = "Sorry"
#	restart.text = "Broken"
	pauseMenu.hide()
	background_loadings.dark = false
	background_loadings.light_theme()
	background_loadings.load_scene("res://Scenes/Spatial.tscn")
	get_tree().paused = false
#	background_loadings.load_scene(get_tree().current_scene)
#	self.queue_free()
#	get_tree().change_scene_to(load("res://Scenes/Spatial.tscn"))
#	background_loadings.load_scene("res://Scenes/Spatial.tscn")
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


onready var touch_buttons = [get_node("CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/Control2/Jump"),
			get_node("CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer2/Control/Right"),
			get_node("CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer2/Control/Left"),
			get_node("CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer2/Control3/UP"),
			get_node("CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer2/Control3/Down")
			]
onready var chkbx = get_node("CanvasLayer/MarginContainer/VBoxContainer/HBoxMenu/Control/ColorRect/HBoxContainer3/CheckBox")
var clkd = true

func _on_CheckBox_pressed():
	if (clkd == true):
		chkbx.pressed = false
		clkd = false
		for btn in touch_buttons:
			btn.hide()
	else:
		chkbx.pressed = true
		clkd = true
		for btn in touch_buttons:
			btn.show()
	pass # Replace with function body.
