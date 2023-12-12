extends Control

const SIMULATED_DELAY_SEC = 0.1

var thread = null
var white = Color(1, 1, 1)
var black = Color(0, 0, 0)
var green = Color(0.286275, 0.498039, 0.498039)
#var orange = Color(0.88916, 0.505932, 0.083359)
var orange = Color(1, 0.768627, 0.435294)
var dark = true

onready var resolution = get_viewport_rect().size

onready var progress = get_node("MarginContainer/VBoxContainer/HBoxContainer2/Progress")
onready var label = get_node("MarginContainer/VBoxContainer/HBoxContainer/Label")
onready var label_control = get_node("MarginContainer/VBoxContainer/HBoxContainer/Control5")
onready var progress_control = get_node("MarginContainer/VBoxContainer/HBoxContainer2/Control3")
onready var bg = get_node("MarginContainer-BG")


func _input(event):
	if Input.is_action_just_pressed("Fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

func _thread_load(path):
	var ril = ResourceLoader.load_interactive(path)
	assert(ril)
	var total = ril.get_stage_count()
	# Call deferred to configure max load steps.
	progress.call_deferred("set_max", total)

	var res = null

	if (dark == false):
		light_theme()
	elif (dark == true):
		dark_theme()

	while true: #iterate until we have a resource
		# Update progress bar, use call deferred, which routes to main thread.
		progress.call_deferred("set_value", ril.get_stage())
		var val = float(ril.get_stage())/ril.get_stage_count()
		#print(val)
		if val < 0.25:
			label.text = "Compiling Resources..."
		if val > 0.25:
			label.text = "Analyzing Bundle..."
		if val > 0.75:
			label.text = "Loading Resources into Memory..."
		# Simulate a delay.
		OS.delay_msec(int(SIMULATED_DELAY_SEC * 1000.0))
		# Poll (does a load step).
		var err = ril.poll()
		# If OK, then load another one. If EOF, it' s done. Otherwise there was an error.
		if err == ERR_FILE_EOF:
			# Loading done, fetch resource.
			res = ril.get_resource()
			break
		elif err != OK:
			# Not OK, there was an error.
			print("There was an error loading")
			break

	# Send whathever we did (or did not) get.
	call_deferred("_thread_done", res)


func _thread_done(resource):
	assert(resource)
	# Always wait for threads to finish, this is required on Windows.
	thread.wait_to_finish()
	# Hide the progress bar.
	progress.hide()
	label.hide()
	bg.hide()
	# Instantiate new scene.
	var new_scene = resource.instance()
	# Free current scene.
	get_tree().current_scene.free()
	get_tree().current_scene = null
	# Add new one to root.
	get_tree().root.add_child(new_scene)
	# Set as current scene.
	get_tree().current_scene = new_scene
	
	progress.visible = false
	label.visible = false
	bg.visible = false

func load_scene(path):
#	progress.visible = true
#	label.visible = true
#	bg.visible = true
	thread = Thread.new()
	thread.start( self, "_thread_load", path)
	raise() # Show on top.


func dark_theme():
	var box_label = label.get_stylebox("normal").duplicate()
	var box_progress_fg = progress.get_stylebox("fg").duplicate()
	var box_progress_bg = progress.get_stylebox("bg").duplicate()
	
	label.rect_position.x = 84
	progress.rect_position.x = 84
	label.visible = true
	progress.visible = true
	
	label.set('custom_colors/font_color' , white)
	box_label.bg_color = black
	box_label.border_color = white
	label.add_stylebox_override("normal", box_label)
	
	progress.set('custom_colors/font_color' , white)
	box_progress_fg.bg_color = green
	box_progress_bg.bg_color = black
	progress.add_stylebox_override("fg", box_progress_fg)
	progress.add_stylebox_override("bg", box_progress_bg)
	
func light_theme():
	var stylebox_label = label.get_stylebox("normal").duplicate()
	var stylebox_progress_fg = progress.get_stylebox("fg").duplicate()
	var stylebox_progress_bg = progress.get_stylebox("bg").duplicate()
	
	label.rect_position.x = resolution.x/3
	progress.rect_position.x = resolution.x/3
	label.visible = true
	progress.visible = true
	bg.visible = true
	
	label.set('custom_colors/font_color' , black)
	stylebox_label.bg_color = white
	stylebox_label.border_color = white
	label.add_stylebox_override("normal", stylebox_label)
	
	progress.set('custom_colors/font_color' , black)
	stylebox_progress_fg.bg_color = orange
	stylebox_progress_bg.bg_color = white
	progress.add_stylebox_override("fg", stylebox_progress_fg)
	progress.add_stylebox_override("bg", stylebox_progress_bg)
