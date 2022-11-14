extends Node

var options = {
	"enable_accessibility_icons": false,
	"show_card_tooltips": true,
	"enable_moon_music": true,
	"save_replays": false,
	"show_enemy_advantage": false,
	"stretch_to_fill": false,
	"fullscreen": false,
	"crt_filter": false
}

func read_options():
	var tFile = File.new()
	if tFile.file_exists(CardInfo.options_path):
		print("Found options.json!")
		tFile.open(CardInfo.options_path, File.READ)
		if parse_json(tFile.get_as_text()):
			var nOptions = parse_json(tFile.get_as_text())
			
			# Do this to preserve defaults
			for opt in nOptions:
				options[opt] = nOptions[opt]

func save_options():
	var sFile = File.new()
	sFile.open(CardInfo.options_path, File.WRITE)
	sFile.store_line(to_json(options))
	sFile.close()


func _ready():
	var d = Directory.new()
	
	if d.file_exists(CardInfo.options_path):
		read_options()
	
	# Graphical options
	if options["stretch_to_fill"] == true:
#		get_viewport().size = OS.window_size
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_IGNORE, Vector2(1920, 1080))

	OS.window_fullscreen = options["fullscreen"]
	
	get_node("/root/Main/Scanlines").visible = options.crt_filter

func _exit_tree():
	# Save to file
	GameOptions.save_options()

