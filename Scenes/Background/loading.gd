extends Node2D

var res_loader : ResourceInteractiveLoader = null
var loading_thread : Thread = null

onready var loading = get_node("CanvasLayer/Loading")
onready var loading_progress = get_node("CanvasLayer/Loading/Progress")
onready var loading_done_timer = get_node("CanvasLayer/Loading/DoneTimer")

onready var main = get_node("CanvasLayer/Main")

signal replace_main_scene
# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interactive_load(loader):
	while true:
		var status = loader.poll()
		if status == OK:
			loading_progress.value = (loader.get_stage() * 100) / loader.get_stage_count()
			continue
		elif status == ERR_FILE_EOF:
			loading_progress.value = 100
			loading_done_timer.start()
			break
		else:
			print("Error while loading level: " + str(status))
			main.show()
			loading.hide()
			break


func loading_done(loader):
	loading_thread.wait_to_finish()
	emit_signal("replace_main_scene", loader.get_resource())
	res_loader = null
	# Weirdly, "res_loader = null" is needed as otherwise
	# loading the resource again is not possible.


func _on_DoneTimer_timeout():
	loading_done(res_loader)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Play_pressed():
	main.hide()
	loading.show()
	var path = "res://Scenes/Spatial.tscn"
	if ResourceLoader.has_cached(path):
		emit_signal("replace_main_scene", ResourceLoader.load(path))
	else:
		res_loader = ResourceLoader.load_interactive(path)
		loading_thread = Thread.new()
		#warning-ignore:return_value_discarded
		loading_thread.start(self, "interactive_load", res_loader)


