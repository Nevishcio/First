extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_button_quit_pressed():
	get_tree().quit()

func _on_button_clear_pressed():
	$TextLength.text = ""
	$TextWidth.text = ""
	$LabelOut.text = ""

func _on_button_calculate_pressed():
	var length = int($TextLength.text)
	var width = int($TextWidth.text)
	var area = length * width
	var perimeter = 2 * length + 2 * width
	$LabelOut.text = "Area: " + str(area) + "\nPerimeter: " + str(perimeter)
