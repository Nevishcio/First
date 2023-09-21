extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_pressed():
	var min = -1000000000000000
	var max = 1000000000000000
	var len = randi()%(max - min) + min
	var area = min * max
	var rnd2 = randf_range (-1000000000000000., 1000000000000000.)
	var rnd = randf()
	$Label.text = "Area : %d\nRound: %f\nRound Two: %f" % [area, rnd, rnd2]
	pass 


func _on_clear_pressed():
	$Label.text = ""


func _on_quit_pressed():
	get_tree().quit()
