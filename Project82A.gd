extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_calculate_pressed():
	var speedLimit = int($TextLimit.text)
	var carSpeed = int($TextSpeed.text)
	var milesOver = carSpeed - speedLimit
	var fine = 20 + (milesOver * 5)
	$LabelOutput.text = "Fine: %.2f" % fine

func _on_button_quit_pressed():
	get_tree().quit()


func _on_button_clear_pressed():
	$LabelOutput.text = ""
	$TextLimit.text = ""
	$TextSpeed.text = ""
